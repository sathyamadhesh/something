<div>
  <div class="container"  style="margin-top:9.3%;margin-left:0%">
      <div class="col-md-6" ng-controller="Controller" ng-init="search()">
        <h3>Ticket Details</h3>
<!--          <li  ng-repeat="abc in datas">
             {{abc.name}} {{abc.name}}
          </li>-->
        <div ng-repeat="ticket in datas">
        <p style="margin-top:2%;">Ticket Id:<label ng-model="ticket_id">{{ticket.id}}</label></p>
        <p style="margin-top:2%;">Ticket Name:<label   ng-model="ticket_name" >{{ticket.name}}</label></p>
        <p style="margin-top:2%;">Ticket Description: <label   ng-model="ticket_description" >{{ticket.description}}</label></p>
        <p style="margin-top:2%;">Ticket Priority: <label   ng-model="ticket_priority" >{{ticket.priority}}</label></p>
        <p style="margin-top:2%;">Ticket Status: <label   ng-model="ticket_status" >{{ticket.status}}</label></p>
        <p style="margin-top:2%;">Ticket Assignto: <label   ng-model="ticket_assignTo" >{{ticket.assignTo}}</label></p>
        <p style="margin-top:2%;">Ticket Project Name: <label   ng-model="ticket_project" >{{ticket.projectname}}</label></p>
        <p style="margin-top:2%;">---------------------------------------------------------------------------------------</p> 
        </div>
      </div>
      <div class="col-md-6" style="margin-top:9.3%;margin-left:0%" ng-controller="Controller" ng-init="search()" >
                     <form>
                          <h4 align="center">LIST OF TICKETS</h4>
                          <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
                          <div align='center' ng-init="search()">
                          <div>
                                <div class="col-md-3">PROJECT</div>
                                <div class="col-md-2">NAME</div>
                                <div class="col-md-3">DESCRIPTION</div>
                                <div class="col-md-2">PRIORITY</div>
                                <div class="col-md-2">STATUS</div>
                          </div>
                          <div ng-repeat ="abc in datas">
                            <div>
                              <a href="#/view/updateticket/{{abc.id}}" id="" ng-click="updateTicketbyId()">
                              <div class="row body-boder">
                                <div class="col-md-3">{{abc.projectname}}</div>
                                <div class="col-md-2">{{abc.name}}</div>
                                <div class="col-md-3">{{abc.description}}</div>
                                <div class="col-md-2">{{abc.priority}}</div>
                                <div class="col-md-2">{{abc.status}}</div>
                             </div>
                              </a>
                            </div>
                          </div>
                          </div>
                    </form>  
              </div>
  </div>
</div>