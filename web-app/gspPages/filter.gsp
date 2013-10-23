<div class="main-body container">
  <div class="row">
        <div class="col-md-8 pull-left" style="margin-top:9.3%;margin-right:5%" ng-controller="Controller" ng-init="filter()">
               <h4 align="center">LIST OF TICKETS</h4>
               <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
                       
               
               
               
               
               <div class="alert alert-success pull-left small">{{data}} tickets are assigned to you</div>
                <p style="margin-left:3%;">Ticket Status:
                                <select id="ticketstatus" name="ticketstatus" ng-model="stats" class="form-control" >
                                      <option value="all" id="all" >ALL</option>  
                                      <option value="new" id="new"  >NEW</option>
                                      <option value="in progress" id="in progress"  >IN PROGRESS</option>
                                      <option value="completed" id="completed"  >COMPLETED</option>
                                </select>
                        </p>
                         <p style="margin-left:3%;">Ticket Priority: 
                                <select id="priority" class="form-control"  ng-model="prios">
                                      <option value="all" id="all" >ALL</option>  
                                      <option value="low" id="low" >LOW</option>  
                                      <option value="high" id="high" >HIGH</option>
                                      <option value="normal" id="normal" >NORMAL</option>
                                      <option value="urgent" id="urgent" >URGENT</option>
                                      <option value="immediate" id="immediate">IMMEDIATE</option>
                                </select>
                        </p>
                       
                        <a href="#/view/filter/{{stats}}/{{prios}}""> <button  type="submit" ng-controller="Controller" class="btn btn-primary" ng-click="filter()">SUBMIT</button></a>
                        
               <div align='center' ng-init="getTicket()" >
                            <div class="table-head row">
                                <div class="col-md-1">ID</div>
                                <div class="col-md-2">PROJECT</div>
                                <div class="col-md-2">NAME</div>
                                <div class="col-md-3">DESCRIPTION</div>
                                <div class="col-md-2">PRIORITY</div>
                                <div class="col-md-2">STATUS</div>
                            </div>

                            <div ng-repeat ="items in code1 | startFrom:currentPage*pageSize | limitTo:pageSize  ">
                                <div>
                                    <a href="#/view/updateticket/{{items.id}}"  style="color: green" id="" ng-controller="updateController" ng-click="updateTicketbyId()">
                                    <div class="row body-boder table-head">
                                        <div class="col-md-1">{{items.id}}</div>
                                        <div class="col-md-2">{{items.project}}</div>
                                        <div class="col-md-2">{{items.name}}</div>
                                        <div class="col-md-3">{{items.desc}}</div>
                                        <div class="col-md-2">{{items.priority}}</div>
                                        <div class="col-md-2">{{items.status}}</div>
                                    </div>
                                    </a>
                                </div>
                            </div>


<!--                            <div ng-repeat ="items in code2">
                                <div>
                                <a href="#/view/updateticket/{{items.id}}" id="" style="color: #002a80" ng-controller="updateController" ng-click="updateTicketbyId()">
                                    <div class="row body-boder table-head">
                                        <div class="col-md-1">{{items.id}}</div>
                                        <div class="col-md-2">{{items.project}}</div>
                                        <div class="col-md-2">{{items.name}}</div>
                                        <div class="col-md-3">{{items.desc}}</div>
                                        <div class="col-md-2">{{items.priority}}</div>
                                        <div class="col-md-2">{{items.status}}</div>
                                    </div>
                                </a>
                              </div>
                        </div>
                        <div ng-repeat ="items in code3">
                            <div>
                              <a href="#/view/updateticket/{{items.id}}" id="" style="color: green" ng-controller="updateController" ng-click="updateTicketbyId()">
                                <div class="row body-boder table-head">
                                      <div class="col-md-1">{{items.id}}</div>
                                      <div class="col-md-2">{{items.project}}</div>
                                      <div class="col-md-2">{{items.name}}</div>
                                      <div class="col-md-3">{{items.desc}}</div>
                                      <div class="col-md-2">{{items.priority}}</div>
                                      <div class="col-md-2">{{items.status}}</div>
                                </div>
                             </a>
                            </div>
                          </div>-->
                 <button ng-disabled="currentPage == 0" ng-click="currentPage=currentPage-1"><<</button>
                       {{currentPage+1}}/{{numberOfPages}}
                       <button ng-disabled="currentPage >= data/pageSize - 1" ng-click="currentPage=currentPage+1">>></button>
                       


               </div>
              </div>
              <div class="col-md-3 pull-right" style="margin-top:12.6%;margin-left:0%" ng-controller="Controller" ng-init="getProject()" >
                              <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
                              <h3>&nbsp;</h3>
                              <h4>&nbsp;</h4>
                              <h4 align="center" class="table-head">PROJECTS</h4>  
                               <div ng-repeat="items in codes | startFrom:currentPage*pageSize | limitTo:pageSize" class="body-boder" style="background:blanchedalmond">
                                <a href="#/view/projectdetails/{{items.id}}"  style="color: green" ng-controller="updateController" ng-click="updateProject()">
                                  <div>{{items.name}} ({{items.sdate}}--{{items.edate}})</div></a>
                                <sub>open({{items.opentickets}})</sub> <sub>new({{items.newtickets}})</sub>
                              </div>
                               <button ng-disabled="currentPage == 0" ng-click="currentPage=currentPage-1">prev</button>
                       {{currentPage+1}}/{{numberOfPages}}
                       <button ng-disabled="currentPage >= data/pageSize - 1" ng-click="currentPage=currentPage+1">More..</button>
                              
                              
                              
<!--                              <div ng-repeat="items in code1" class="body-boder" style="background:blanchedalmond">
                                <a href="#/view/projectdetails/{{items.id}}"  style="color: red" ng-controller="updateController" ng-click="updateProject()">
                                  <div>{{items.name}} ({{items.sdate}}--{{items.edate}})</div></a>
                                <sub>open({{items.opentickets}})</sub> <sub>new({{items.newtickets}})</sub>
                              </div>
                              <div ng-repeat="items in code2" class="body-boder" style="background:blanchedalmond">
                                <a href="#/view/projectdetails/{{items.id}}" style="color: #002a80" ng-controller="updateController" ng-click="updateProject()">
                                  <div>{{items.name}} ({{items.sdate}}--{{items.edate}})</div></a>
                                <sub>open({{items.opentickets}})</sub> <sub>new({{items.newtickets}})</sub>
                              </div>
                              <div ng-repeat="items in code3" class="body-boder" style="background:blanchedalmond">
                                <a href="#/view/projectdetails/{{items.id}}" style="color: green" ng-controller="updateController" ng-click="updateProject()">
                                  <div>{{items.name}} ({{items.sdate}}--{{items.edate}})</div></a>
                                <sub>open({{items.opentickets}})</sub> <sub>new({{items.newtickets}})</sub>
                              </div>-->
              </div>
  </div>
</div>





<style>
.main-body{
  width: 960px;
  margin: auto;
}
.main-body .table-head{
  background: #E9E9E9;
  border-bottom: solid 1px #e3e3e3;
  overflow: hidden;
  padding: 15px 5px 15px 5px;
  margin-bottom: 10px;
}
</style>

