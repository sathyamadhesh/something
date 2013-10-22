<div class="main-body container">
  <div class="row"  >
      
      <div class="col-md-8 pull-left" style="margin-top:9.3%;margin-left:5%" ng-controller="Controller" ng-init="search()" >
        <div flash-alert="success" active-class="in" class="alert fade">
    <strong class="alert-heading">Congrats!</strong>
    <span class="alert-message">{{flash.message}}</span>
</div>
        <div flash-alert="error" active-class="in" class="alert fade">
                            <strong class="alert-heading">Boo!</strong>
                            <span class="alert-message">{{flash.message}}</span>
                  </div>
                                          <form>
                          <h4 align="center">TICKETS RELATED TO THE QUERY</h4>
                          <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
                          <div class="alert alert-success pull-left small">Found {{data}} Tickets</div>
                          <div align='center' ng-init="search()">
                          <div class="row table-head">
                                <div class="col-md-3">PROJECT</div>
                                <div class="col-md-2">NAME</div>
                                <div class="col-md-3">DESCRIPTION</div>
                                <div class="col-md-2">PRIORITY</div>
                                <div class="col-md-2">STATUS</div>
                          </div>
                         <div ng-repeat ="items in datas1 | startFrom:currentPage*pageSize | limitTo:pageSize">
                            <div>
                              <a href="#/view/updateticket/{{items.id}}" style="color: red" id="" ng-click="updateTicketbyId()">
                              <div class="row body-boder table-head">
                                <div class="col-md-3">{{items.projectname}}</div>
                                <div class="col-md-2">{{items.name}}</div>
                                <div class="col-md-3">{{items.description}}</div>
                                <div class="col-md-2">{{items.priority}}</div>
                                <div class="col-md-2">{{items.status}}</div>
                             </div>
                              </a>
                            </div>
                          </div>
                        <button ng-disabled="currentPage == 0" ng-click="currentPage=currentPage-1"><<</button>
                       {{currentPage+1}}/{{numberOfPages}}
                       <button ng-disabled="currentPage >= data/pageSize - 1" ng-click="currentPage=currentPage+1">>></button>
                        
                          </div>
                    </form>  
              </div>
    <div class="col-md-3 pull-right" style="margin-top:12.6%;margin-left:0%" ng-controller="Controller" ng-init="getProject()" >
                              <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
                              <h3>&nbsp;</h3>
                              <h4>&nbsp;</h4>
                              <h4 align="center" class="table-head">PROJECTS</h4>  
                              <div ng-repeat="items in code1" class="body-boder" style="background:blanchedalmond">
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
                              </div>
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
