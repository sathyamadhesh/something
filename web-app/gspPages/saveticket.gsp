<div class="container" style="margin-top:1.3%;margin-left:5%" ng-controller="updateController" ng-init="saveTic()">
          <ul class="list-inline">
          <li class="col-md-4"></li>
          <li class="col-md-5 body-boder1">
              <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
              <div flash-alert="error" active-class="in" class="alert fade">
                       <strong class="alert-heading">Boo!</strong>
                       <span class="alert-message">{{flash.message}}</span>
              </div>
              
              <h3 align="left" style="color:#289EF2">Create Ticket</h3>
              <hr style="background:#1df772; border:0; height:1px; " />
              <form ng-submit="saveTicket()">
                        <p style="margin-left:3%">TicketName<input type="text" class="form-control" ng-model="ticketname"   placeholder="Name of Ticket" required=""></p>
                        <p style="margin-left:3%">Description Of The Ticket
                                <textarea class="form-control" rows="2" cols="20" ng-model="ticketdesc" placeholder="Description of the Ticket" required=""></br>
                                </textarea>
                        </p>
                        <p style="margin-left:3%;">Ticket Status:
                                <select id="ticketstatus" ng-init="ticketstatus='new' "name="ticketstatus" required="" ng-model="ticketstatus" class="form-control" >
                                      <option value="new" id="new"  >NEW</option>
                                </select>
                        </p>
                        <p style="margin-left:3%;">Ticket Assignto: 
                                <select ng-model="user" id="users" class="form-control" ng-controller="updateController" ng-init="getAllUsersForProjectId(id)" required="">
                                      <option value="" style="display:none">Please select</option>
                                      <option ng-repeat="items in codess" value="{{items.email}}" selected="selected"> {{items.name}} </option>
                                </select>
                        </p>
                        <p style="margin-left:3%">Date going to start Ticket<input type="date" class="datepicker1 form-control" id="datepicker" ng-model="startdate" required=""/></p>
                        <p style="margin-left:3%">End Date Of Ticket<input type="date" class="datepicker1 form-control" id="datepicker" ng-model="enddate" required=""/></p>
                        <p style="margin-left:3%;">Ticket Priority: 
                                <select id="priority" class="form-control" required=""> 
                                      <option value="low" id="low" >LOW</option>  
                                      <option value="high" id="high" >HIGH</option>
                                      <option value="normal" id="normal" >NORMAL</option>
                                      <option value="urgent" id="urgent" >URGENT</option>
                                      <option value="immediate" id="immediate">IMMEDIATE</option>
                                </select>
                        </p>
                        <p style="margin-left:3%">
                              <button type="submit" class="btn btn-primary" ng-controller="updateController">SUBMIT</button>
                              <a href="#/view/project/{{id}}"><button style="margin-left: 5%" type="button" class="btn btn-primary">CANCEL</button></a>
                        </p>
              </form>
          </li>
          <li class="col-md-1"></li>
          </ul>
</div>