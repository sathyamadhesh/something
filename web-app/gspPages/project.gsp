<div id="div1" >
  <div class="container main-body">
                <div class="col-md-1" style="margin-top:13.4%;margin-left:0%;margin-right:3%" ng-controller="updateController" ng-init="save()">
                   <div flash-alert="error" active-class="in" class="alert fade">
                       <strong class="alert-heading">Boo!</strong>
                       <span class="alert-message">{{flash.message}}</span>
              </div>

                 <p>
                   <a href="#/view/saveticket/{{id}}" ng-controller="updateController" >
                    <button type='button' class="btn btn-primary"  ng-controller="updateController" ng-click="saveTic()">
                           +Create Ticket
                    </button>
                   </a>
                 </p>
                 <p>
                    <a href="#/view/addmembers/{{id}}" ng-controller="newController" >
                       <button type='button' class="btn btn-primary"  ng-controller="newController" ng-click="addmembers()">
                           +Add Members
                       </button>
                    </a>
                 </p>
                </div>
              <div class="col-md-8 " style="margin-top:9.4%;margin-left:4%;margin-right:1%" ng-controller="updateController" ng-init="listproject()">
                    <h4 align="center">LIST OF TICKETS OF THE PROJECT</h4>
                    <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
                     <div class="alert alert-success pull-left small">{{data}} tickets are raised for this project</div>
                    <div class="table-head row">
                            <div class="col-md-1">ID</div>
                            <div class="col-md-2">NAME</div>
                            <div class="col-md-3">DESCRIPTION</div>
                            <div class="col-md-2">PRIORITY</div>
                            <div class="col-md-2">STATUS</div>
                            <div class="col-md-2 pull-right">ASSIGN-TO</div>
                    </div>
<!--                   <div ng-repeat ="items in codenf1">
                         
                            <div>
                              <a href="#/view/updateticket/{{items.id}}" style="color: red" id="" ng-controller="updateController" ng-click="updateTicketbyId()">
                              <div class="row body-boder"> 
                                                             
                                <div class="col-md-1">{{items.id}}</div>
                                <div class="col-md-2">{{items.name}}</div>
                                <div class="col-md-3">{{items.desc}}</div>
                                <div class="col-md-2">{{items.priority}}</div>
                                <div class="col-md-2">{{items.status}}</div>
                                <div class="col-md-2 pull-right">{{items.assignTo}}</div>
                             </div>
                              </a>
                            </div>
                          </div>
                            <div ng-repeat ="items in codenf2">
                         
                            <div>
                              <a href="#/view/updateticket/{{items.id}}" id="" style="color: #002a80" ng-controller="updateController" ng-click="updateTicketbyId()">
                              <div class="row body-boder"> 
                                 <div class="col-md-1">{{items.id}}</div>                            
                                <div class="col-md-2">{{items.name}}</div>
                                <div class="col-md-3">{{items.desc}}</div>
                                <div class="col-md-2">{{items.priority}}</div>
                                <div class="col-md-2">{{items.status}}</div>
                                <div class="col-md-2 pull-right">{{items.assignTo}}</div>
                             </div>
                              </a>
                            </div>
                          </div>-->
                            <div ng-repeat ="items in codenf3 | startFrom:currentPage*pageSize | limitTo:pageSize | filter:searchBar | orderBy:orderProp">
                         
                            <div>
                              <a href="#/view/updateticket/{{items.id}}" id="" style="color: green" ng-controller="updateController" ng-click="updateTicketbyId()">

                              <div class="row body-boder"> 
                                 <div class="col-md-1">{{items.id}}</div>                            
                                <div class="col-md-2">{{items.name}}</div>
                                <div class="col-md-3">{{items.desc}}</div>
                                <div class="col-md-2">{{items.priority}}</div>
                                <div class="col-md-1">{{items.status}}</div>
                                <div class="col-md-2 pull-right">{{items.assignTo}}</div>
                             </div>
                              </a>
                            </div>
                              
                          </div>
<h6>&nbsp;</h6>
 <button ng-disabled="currentPage == 0" ng-click="currentPage=currentPage-1"><<</button>
                       {{currentPage+1}}/{{numberOfPages}}
                       <button ng-disabled="currentPage >= data/pageSize - 1" ng-click="currentPage=currentPage+1">>></button>
<!--<div class='span2'>
            Search: <input ng-model='searchBar'>
            Sort by: 
            <select ng-model='orderProp'>
                <option value='name'>Alphabetical</option>
                <option value='id'>Newest</option>
            </select>
        </div>-->
                                              </div>
             
              <div class="col-md-2" style="margin-top:12.4%;margin-left:0%" ng-controller="updateController" ng-init="listmembers()">
                              <h3>&nbsp;</h3>
                              <h6>&nbsp;</h6>
                      <h4 align="center" class="table-head">MEMBERS</h4>
                      <div ng-repeat ="datas in data" style="background:blanchedalmond">
                        <div class="body-boder"><b>{{datas.username}}</b>--{{datas.role}}</div>                             
                     </div>
              </div>
     </div>
  </div>
</div>
                            
<style>
.main-body{
  width: 1150px;
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