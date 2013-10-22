<div>
  <div class="container body-boder1" ng-controller="updateController" ng-init="updateTicketbyId()" style="margin-top:4%;margin-left:0%">
    <div flash-alert="error" active-class="in" class="alert fade">
    <strong class="alert-heading">Boo!</strong>
    <span class="alert-message">{{flash.message}}</span>
</div>

    <h3 align="center" style="color:#289EF2">UPDATE TICKET</h3> 
    <hr style="background:#1df772; border:0; height:1px; " />
    <ul class="list-inline">
      <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
      <div class="col-md-12 ">
              <div class="col-md-6">
                  <li class="col-md-1">
                  </li>
                  <li class="col-md-11 body-boder1"  >
                  <h3>Current Ticket Details</h3>
                  <div ng-repeat="ticket in datas">
                        <p style="margin-top:2%;">Ticket Id:<label ng-model="ticket_id">{{ticket.id}}</label></p>
                        <p style="margin-top:2%;">Ticket Name:<label   ng-model="ticket_name" >{{ticket.name}}</label></p>
                        <p style="margin-top:2%;">Ticket Description: <label   ng-model="ticket_description" >{{ticket.description}}</label></p>
                        <p style="margin-top:2%;">Ticket Priority: <label   ng-model="ticket_priority" >{{ticket.priority}}</label></p>
                        <p style="margin-top:2%;">Ticket Status: <label   ng-model="ticket_status" >{{ticket.status}}</label></p>
                        <p style="margin-top:2%;">Ticket Assignto: <label   ng-model="ticket_assignTo" >{{ticket.assignTo}}</label></p>
                        <p style="margin-top:2%;">Ticket Project Name: <label   ng-model="ticket_project" >{{ticket.projectname}}</label></p>
                  </div>
                  </li>
              </div>
              <div class="col-md-6">
                  <li class="col-md-1">
                  </li>
                  <li class="col-md-11 body-boder1"  ng-repeat="ticket in datas">
                  <form ng-submit="updateTickets(ticket.id,ticket.projectname,ticket.assignemail,ticket.status,ticket.priority)" >
                          <h3>Update Ticket Details</h3>
                          <p style="margin-top:2%;">Ticket Priority: <select id="priority"  class="form-control" name="priority" ng-model="priority" required="">
                                  <option value="high"   id="high" >high</option>
                                  <option value="medium"   id="medium" >medium</option>
                                  <option value="low"   id="low" >low</option>  
                                  <option value="normal" id="normal" >normal</option>
                                  <option value="urgent"  id="urgent" >urgent</option>
                                  <option value="immediate" id="immediate">immediate</option>
                                  </select>
                          </p>
                          <p style="margin-top:2%;">Ticket Status: <select id="status" class="form-control"  name="status" required="">
                                  <option ng-repeat="items in array" value="{{items}}">{{items}}</option>
                                  </select>
                          </p>
                          <p style="margin-top:2%;">Ticket Assignto: 
                                <select  id="assignTo"   class="form-control" name="assignTo" ng-init="getAllUsersForProject(ticket.projectname)" ng-model="items.assignTo" required="">
                                <option value="" style="display:none">Please select</option>
                                <option ng-repeat="assign in codess" value="{{assign.name}}"> {{assign.name}} </option>
                                </select>
                          </p>
                          <p style="margin-top:2%;">
                                Comments:<textarea ng-model="comment"  class="form-control" rows="2" cols="20" id="comment"  placeholder="Comment On The Ticket" >
                                        </textarea>
                          </p>
                          <p style="margin-top:2%;"><button  type="submit" class="btn btn-primary"  >SUBMIT</button></p>
                  </form>
                </li>
            </div>
      </div>
      <div>
      <div class="col-md-12" ng-repeat="items in hist" style="margin-top:8%;margin-left:0%">
          <li class="col-md-1">
          </li>
          <li class="col-md-11  body-boder1" style="margin-top:3%;margin-left:5%;background:blanchedalmond">
            <h3>History</h3>
            <p style="margin-top:2%;">Ticket comment: <label>{{items.comments}}</label></p>
            <p style="margin-top:2%;">Ticket status: status from <label>{{items.oldstatus}}</label> to <label>{{items.cstatus}}</label></p>
            <p style="margin-top:2%;">Updated by &nbsp; &nbsp; <label>{{items.lastupdatedby}}</label> &nbsp; on &nbsp; <label>{{items.updatedon}}</label></p>
          </li>
          
        </div> </p>      
      </div>
    </ul>
    </form> 
  </div>
</div>