<div style="margin-top:3.3%;margin-left:0%" ng-controller="Controller">  

<div flash-alert="error" active-class="in" class="alert fade">
    <strong class="alert-heading">Boo!</strong>
    <span class="alert-message">{{flash.message}}</span>
</div>


                    <ul class="list-inline body-boder">
                          <li class="col-md-4"></li>
                          <li class="col-md-5 body-boder">
                                    <form ng-submit="saveProject()">
                                          <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
                                          <h3 align="left" style="color:#289EF2">Create New Project</h3>
                                          <hr style="background:#1df772; border:0; height:1px; " />
                                          <p style="margin-left:1%">Name of Project<input type="text" class="form-control" ng-model="projectname"   placeholder="Name of Project" required></p>
                                          <p style="margin-left:1%">Description Of The Project<textarea class="form-control" rows="2" cols="20" ng-model="projectdesc"  placeholder="Description Of The Project" required>
                                              </textarea></p>
                                              <p style="margin-left:1%">Date going to start Project<input type="date" class="datepicker1 form-control" id="datepicker" ng-model="startdate" required=""/></p>
                                              <p style="margin-left:1%">End Date Of Project<input type="date" class="datepicker1 form-control" id="datepicker" ng-model="enddate" required=""/></p>
                                   
                                          <p style="margin-left:1%;">Project Manager
                                              <select ng-model="user" id="users" class="form-control" ng-controller="Controller" ng-init="getAllUsers()" required="">
                                                    <option value="" style="display:none">Please select</option>
                                                    <option ng-repeat="datas in data" value="{{datas.email}}" selected="selected"> {{datas.name}} </option>
                                              </select>
                                          </p>
                                          <p style="margin-left:1%"><button type="submit" class="btn btn-primary">SUBMIT</button> <a href="#/view/ticketlist"><button style="margin-left: 5%" type="button" class="btn btn-primary">CANCEL</button></a></p>
                                          
                                    </form>     
                          </li>
                          <li class="col-md-1"></li>
                    </ul>
</div>
