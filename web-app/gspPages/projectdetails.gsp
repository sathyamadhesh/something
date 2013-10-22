  <div  class="container" ng-controller="updateController" style="margin-top:3.3%;margin-left:0%">
                  <div flash-alert="error" active-class="in" class="alert fade">
                            <strong class="alert-heading">Boo!</strong>
                            <span class="alert-message">{{flash.message}}</span>
                  </div>
        <h3 align="center" style="color:#289EF2">UPDATE PROJECT</h3> 
        <hr style="background:#1df772; border:0; height:1px; " />
        <ul class="list-inline" ng-init="updateProject()">
                <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
                <li class="col-md-1"></li>
                <li class="col-md-5 body-boder" ng-repeat="data in datas">
                              <h3>Current Project Details</h3>
                              <p style="margin-top:2%;">Project Id:<label ng-model="projectid">{{data.id}}</label></p>
                              <p style="margin-top:2%;">Project Name:<label   ng-model="projectname" >{{data.name}}</label></p>
                              <p style="margin-top:2%;">Project Description: <label   ng-model="projectname" >{{data.desc}}</label></p>
                              <p style="margin-top:2%;">Project Status: <label   ng-model="projectname" >{{data.status}}</label></p>
                              <p style="margin-top:2%;">Project Manager Name: <label   ng-model="projectname" >{{data.managername}}</label></p>
                              <p style="margin-top:2%;">Project Manager MailId: <label   ng-model="projectname" >{{data.managermail}}</label></p>
                              <p style="margin-top:2%;">Open Tickets Of Project: <label   ng-model="projectname" >{{data.opentickets}}</label></p>
                              <p style="margin-top:2%;">New Tickets Of Project: <label   ng-model="projectname" >{{data.newtickets}}</label></p>
                </li>
                <li class="col-md-1"></li>
                <li class="col-md-5 body-boder" ng-repeat=" data in datas">
                              <h3>Update Project Details</h3>
                              <p style="margin-top:2%;">Project Short Description:<input type="text" class="form-control"  value="{{data.desc}}" id="projectdescription"/></p>
                              <p style="margin-top:2%;">Project Status: 
                                        <select id="projectstatus" name="projectstatus" required="required"  class="form-control" >
                                              <option ng-repeat="items in array" value="{{items}}">{{items}}</option>
                                        </select>
                              </p>
                              <p style="margin-top:2%;">

<button type="submit" ng-controller="updateController" class="btn btn-primary" ng-click="updateProjects(data.id)">SUBMIT</button>

                                        
                              </p>
                </li>
</ul>
</div>