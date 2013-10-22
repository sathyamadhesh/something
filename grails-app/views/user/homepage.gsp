<!DOCTYPE html>
<html data-ng-app="trac">
  <head>
    <title>TICKER</title>
      <script type="text/javascript">
window.onload = function preventback() {
window.history.forward();}
setTimeout("preventback()", 10);
window.onunload=function(){null};

</script>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"/>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.0.8/angular.min.js"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'angular-flash.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'commonDivStyle.css')}" type="text/css" />

  </head>

  <body>



    <!-- for user authentication-->
    <input type="hidden" name="token" id="token" value="${params.token}"/>



    <!-- Header Part Start here-->
    <div class="wrapper" style="margin-top:0%;margin-left:0%">
      <div class="container pull-left" ><h3 style="color:white">TICKER</h3>
      </div>
      <div class="container pull-right" style="margin-right:-1.2%" ng-controller="Controller" ng-init="getProject()">
        <ul class="menu" >
          <form class="navbar-form navbar-left" role="search" ng-submit="search()">
            <div class="form-search">
              <div class="input-append" ng-controller="Controller"> 
                <input type="text" id="q" ng-model="q" name="q" class="span2 search-query btn-sm" placeholder="Search"/>
                <button class="btn btn-primary btn-sm" type="submit" >search</button>
              </div>
            </div>
          </form>
          <li id="bar1"><a href="#/view/ticketlist"><button type="button" class="btn btn-link" style="color:#1CE62A;">DASHBOARD</button></a></li>
          <li class="dropdown" style="color:#1CE62A ; ">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color:#1CE62A">PROJECTS<b class="caret"></b></a>
            <ul class="dropdown-menu" style="overflow-y: auto; max-height: 200px;">
              <li ng-repeat="abc in codes" class="top-main-manue"><a href="#/view/project/{{abc.id}}" ng-controller="updateController" ng-click="listproject();listmembers();save()" style="color:#1CE62A">{{abc.name}}</a></li>
            </ul>
          </li> 
          <li id="bar4"><a href="#/view/saveproject"><button type="button" class="btn btn-link btn-sm" style="color:#1CE62A;">Create Project</button></a></li>
          <li id="bar2"><a href="#/view/myaccount"><button type="button" class="btn btn-link btn-sm" style="color:#1CE62A;">My Account</button></a></li>
          <li id="bar3"><a href="http://localhost:8080/trac/user/logout?token=${params.token}"><button type="button" class="btn btn-link btn-sm" style="color:#1CE62A;"><i class="icon-white icon-off">Log Out</i></button></a></li>
        </ul>
      </div>
    </div> 
    <!-- Header Part End here-->

    <br><br><br>

    <!-- Changing DIV -->    

    <div ng-view></div>

    <!-- Route configuration -->

    <script>
       var trac = angular.module("trac", ['angular-flash.flash-alert-directive']);          
       trac.config(function ($routeProvider){
              $routeProvider
              .when('/view/ticketlist',
              {
                    
                  controller: 'Controller',
                  templateUrl: "${resource(dir: 'gspPages', file: 'ticketlist.gsp')}"
              })
              .when('/view/search/:str',
                {
                    
                    controller: 'Controller',
                    templateUrl: "${resource(dir: 'gspPages', file: 'search.gsp')}"
                })
                .when('/view/filter/:status/:priority',
                {
                    
                    controller: 'Controller',
                    templateUrl: "${resource(dir: 'gspPages', file: 'filter.gsp')}"
                })
                
              .when('/view/myaccount',
              {
                    
                  controller: 'Controller',
                  templateUrl: "${resource(dir: 'gspPages', file: 'myaccount.gsp')}"
              })
              .when('/view/updateticket/:id',
                {
                    
                    controller: 'Controller',
                    templateUrl: "${resource(dir: 'gspPages', file: 'updateticket.gsp')}"
                })
              .when('/view/addmembers/:id',
              {
                    
                  controller: 'newController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'addmembers.gsp')}"
              })
               .when('/view/addprojectmembers/:id',
              {
                    
                  controller: 'newController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'project.gsp')}"
              })
              .when('/view/project/:id',
              {
                    
                  controller: 'updateController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'project.gsp')}"
              })
              .when('/view/saveproject',
              {
                    
                  controller: 'Controller',
                  templateUrl: "${resource(dir: 'gspPages', file: 'saveproject.gsp')}"
              })
              .when('/view/saveticket/:id',
              {
                    
                  controller: 'Controller',
                  templateUrl: "${resource(dir: 'gspPages', file: 'saveticket.gsp')}"
              })
               .when('/view/createticket/:id',
              {
                    
                  controller: 'Controller',
                  templateUrl: "${resource(dir: 'gspPages', file: 'ticketlist.gsp')}"
              })
               .when('/view/createproject',
              {
                    
                  controller: 'Controller',
                  templateUrl: "${resource(dir: 'gspPages', file: 'ticketlist.gsp')}"
              })
              .when('/view/projectdetails/:id',
              {
                    
                  controller: 'updateController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'projectdetails.gsp')}"
              })
              .when('/view/update/:id',
              {
                    
                  controller: 'updateController',
                  templateUrl: "${resource(dir: 'gspPages', file: 'updateticket.gsp')}"
              })
              .otherwise( {redirectTo: '/view/ticketlist'} );
          }
      );
     
   // <!-- End Route configuration -->  
     //<1--start filter configuration-->
     trac.filter('startFrom', function() {
    return function(input, start) {
        start = +start; //parse to int
        return input.slice(start);
    }
}); 
     
     
     //<!-- newController -->  
     trac.controller("newController", function ($location,$routeParams,$scope,$http,flash)
      {

          
        
        var sessionToken = document.getElementById("token").value;
        
        $scope.addmembers = function()
        {
          this.params=$routeParams
           $scope.code = this.params.id
        };
          $scope.addProjectMembers = function(code)//adding project members
              {
                    var id=code
                    var projectJSON = '{"email" :' + $scope.user + ',"role" : ' + $scope.role + ', "token" : ' + sessionToken + ',"id":'+id+'}';
                    $http.post("/trac/savemembers", projectJSON)
                      .success(function(data, status, headers, config)
                      {
                        
                        if(data.response.code==200)
                          {
                            $location.path("/view/addprojectmembers/"+id)
                          }
                        else
                          {
                            flash.error=data.response.status
                          }
                            
                      })
                      .error(function(data, status, headers, config)
                      {
                            alert("Error" + data.response.status);
                      });
              };
     }); 
     //<!-- newController end -->
   
   
     //<!-- updateController -->  
      trac.controller("updateController", function ($location,$routeParams,$scope,$http,flash)
      {

         
        
        var sessionToken = document.getElementById("token").value;
        
        
        $scope.getAllUsersForProjectId = function(id)//get users of a project
        {
          
          var tempss = new Array()
          var varcount=0
          $http.get("/trac/getUsersForProjectId",{  params: { Id: id, token: sessionToken  }})
          .success(function(ytdata) 
          {
            if(ytdata.response.code==200)
              {
                for(var i=0;i<ytdata.response.name.length;i++)
                {
                  var temp = {"name":ytdata.response.name[i],"email":ytdata.response.email[i]}
                  tempss[varcount++]=temp
                }
                $scope.codess = tempss;
              }
          })
          .error(function(data, status, headers, config)
          {
              alert("Error" + data.response.error);
          });
        }
        $scope.listmembers = function() //get list of users
        {
          this.params = $routeParams;
          $scope.id = this.params.id
          var pid=$scope.id
          $http.get("/trac/listmembers",{  params: { id: pid , token: sessionToken  }})
          .success(function(ytdata) 
          {
              
              $scope.data = ytdata;
          })
          .error(function(data, status, headers, config)
          {
              alert("Error" + data.response.status);
          });
        };
        
        $scope.getAllUsersForProject = function(ticket_project)
        {
          var tempss = new Array()
          var varcount=0
          $http.get("/trac/getUsersForProject",{  params: { name: ticket_project , token: sessionToken  }})
          .success(function(ytdata) 
          {
            if(ytdata.response.code==200)
              {
                for(var i=0;i<ytdata.response.name.length;i++)
                {
                  var temp = {"name":ytdata.response.name[i],"email":ytdata.response.email[i]}
                  tempss[varcount++]=temp
                }
                $scope.codess = tempss;
              }
          })
          .error(function(data, status, headers, config)
          {
              alert("Error" + data.response.code);
          });
        };
        
        
            $scope.updateTicketbyId = function() //update ticket
        {
                    
                    this.params = $routeParams;
                    $scope.ticket_id = this.params.id
                    renderTicketPage($scope.ticket_id)
                   
         };


   function renderTicketPage(ticketId){
                    var temps = new Array()
                    var varcount=0
                    var count=1
                    var strs
                    var array1 = new Array();
                    var str = new Array();
                    var ids = $scope.ticket_id
                    $http.get("/trac/ticket/"+ids, {  params: { token: sessionToken  }
                    }).success(function(data,status,headers,config)
                    {
                      if(data.response.code==200)
                      {
                        
                          $scope.datas = data
                          console.log(JSON.stringify(data));
                          $scope.priority=data.response.priority
                          for(var i=0;i<data.response.cstatus.length;i++)
                          {
                              var temp = {"count":count,"cstatus":data.response.cstatus[i],"oldstatus":data.response.oldstatus[i],"lastupdatedby":data.response.lastupdatedby[i],"updatedon":data.response.updatedon[i],"comments":data.response.comments[i]}
                              temps[varcount++]=temp
                          }
                          
                          $scope.hist = temps
                          if(data.response.status == "new")
                          {
                                 array1[0] = "new"
                                 array1[1] = "in progress"
                          }
                          else if(data.response.status == "in progress")
                          {
                                 array1[0] = "in progress"
                                 array1[1] = "completed"
                          }
                          else if(data.response.status == "completed")
                          {
                                 array1[0] = "completed"
                          }
                          $scope.array = array1
                     }
                     else
                     {
                     }
                    }).error(function(data,status,headers,config){
                              alert("Error"+data.response.error);
                    });
         }
          

           $scope.updateProject = function()
        {
                    this.params = $routeParams;
                    $scope.project_id = this.params.id;
                    $scope.projectDetails($scope.project_id);
         };
         
         $scope.updatepro=function(id,desc,edate,status,user)
         {
           var projectJSON = '{"description":'+desc+',"manager":'+user +',"status":'+status +',"edate":'+edate +',"token":'+sessionToken+',"id":'+id+'}';
            console.log(JSON.stringify(projectJSON));
         
              $http.put("/trac/projectupdate",projectJSON)
                      .success(function(data,status,headers,config)
                        {
                          if(data.response.code==200)
                            {
                              $location.path("#/view/ticketlist")
                              location.reload()  
                                                
                            }
                            else
                              {
                                location.reload()
                              }
                        })
                       .error(function(data,status,headers,config)
                        {
                               alert("Error"+data.response.error);
                        }); 
                        $location.reload()
         };
         
         
         $scope.projectDetails = function(projectid) 
         {
           var array1 = new Array();
                 $http.get("/trac/project/"+projectid, {  params: {  token: sessionToken  }})
                    .success(function(data,status,headers,config)
                    {
                          if(data.response.code===200)
                          {
                            $scope.datas = data;
                             if(data.response.status == "new")
                                        {
                                          array1[0] = "new"
                                          array1[1] = "in progress"
                                        }
                                        else if(data.response.status == "in progress")
                                        {
                                          array1[0] = "in progress"
                                          array1[1] = "completed"
                                        }
                                        else if(data.response.status == "completed")
                                        {
                                          array1[0] = "completed"
                                        }
                                   
                                     $scope.array = array1
                          }
                          $scope.temp = data.response.code;
                    }).error(function(data,status,headers,config){
                              alert("Error"+data.response.error);
                    });
         };
         
         
       
         $scope.updateProjects = function(id) //update project method
         {
           var projectstatus=document.getElementById("projectstatus").value;
           var description=document.getElementById("projectdescription").value
              var ticketJSON = '{"description":'+description+',"status":'+projectstatus +',"token":'+sessionToken+',"id":'+id+'}';
              $http.put("/trac/projectupdate",ticketJSON)
                      .success(function(data,status,headers,config)
                        {
                          if(data.response.code==200)
                            {
                                  $location.path("#/view/ticketlist")
                            }
                          else
                            {
                              flash.error=data.response.status
                            }
                        })
                       .error(function(data,status,headers,config)
                        {
                          flash.error=data.response.status
                               //alert("Error"+data.response.error);
                        });       
         };
          $scope.listproject = function() //get all projects belonging to user
              { 
                 $scope.currentPage = 0;
                 $scope.pageSize = 3;
                this.params = $routeParams;
                $scope.id = this.params.id
                var pid=$scope.id
                var temps1 = new Array();
                    var count1=0;
                    var temps2 = new Array();
                    var count2=0;
                    var temps3 = new Array();
                    var count3=0;
                    $http.get("/trac/listticket",{  params: { id: pid , token: sessionToken  }})
                    .success(function(ytdata) 
                    {
                       $scope.data=ytdata.response.id.length
                       $scope.numberOfPages=Math.ceil(ytdata.response.id.length/$scope.pageSize);
                              if(ytdata.response.code==200)
                          {
                              for(var i=0 ; i < ytdata.response.id.length ; i++)
                                {
                                          var temp = {"id":ytdata.response.id[i],"name":ytdata.response.name[i],"priority":ytdata.response.priority[i],"project":ytdata.response.project[i],"desc":ytdata.response.desc[i],"status":ytdata.response.status[i],"assignTo":ytdata.response.assignTo[i]};
                                          temps3[count3++]=temp
                                          
                                }
                                $scope.project = ytdata.response.project[0]
                                $scope.codenf3 = temps3 
                               
                          }
                    })
                    .error(function(data, status, headers, config)
                    {
                              
                            alert("Error" + data.response.error);
                    });
              };
         $scope.updateTickets = function(id,project,assigns,oldstatus,oldpriority)
         {
              var priorit=document.getElementById("priority");
              var priority = priorit.options[priorit.selectedIndex].value;
              var stat=document.getElementById("status");
              var status = stat.options[stat.selectedIndex].value;
              var assign=document.getElementById("assignTo");
              var assignTo = assign.options[assign.selectedIndex].value;
              var comment1=document.getElementById("comment").value;
              var comment = "'"+comment1+"'";
              $scope.update(id,project,assigns,oldpriority,priority,comment,status,assignTo,oldstatus);
         }
         $scope.update = function(ticketid,projectid,previousassign,oldpriority,newpriority,comment,newstatus,newassignto,oldstatus)
         {
                if(comment)
                {
                  ticketJSON = {"priority":newpriority,"status": newstatus,"oldstatus":oldstatus,"projectname":projectid,"token": sessionToken,"assignTo":newassignto,"comment":comment,"id":ticketid,"assigns":previousassign};
                  console.log(JSON.stringify(ticketJSON));
                }
                else
                {
                     ticketJSON = {"priority":newpriority,"status": newstatus,"oldstatus":oldstatus,"projectname":projectid,"token": sessionToken,"assignTo":newassignto,"comment":"","id":ticketid,"assigns":previousassign};
                     alert(JSON.stringify(ticketJSON));
                }
                      $http.put("/trac/ticketupdate",ticketJSON)
                      .success(function(data,status,headers,config)
                        {
                            if(data.response.code==200)
                              {
                                $location.path("#/view/ticketlist");
                              }
                        })
                       .error(function(data,status,headers,config)
                        {
                               alert("Error"+data.response.error);
                        });
         }
         $scope.updatetickets = function(id,project,assigns,currentstat,old)//update ticket method
         {
            
            $scope.update(id,project,assigns,old,$scope.ticket.priority,$scope.Comment,$scope.ticket.status,$scope.ticket.assignTo,currentstat);
         }
         $scope.save=function() 
         {
                    this.params = $routeParams;
                    $scope.id = this.params.id
         }
         $scope.saveTic=function() //returns project id
         {
                    this.params = $routeParams;
                    $scope.id = this.params.id
         }
         $scope.saveTicket = function() //save ticket method
         {
                    this.params = $routeParams;
                    $scope.id = this.params.id
                   var code=$scope.id
                    var manager2=document.getElementById("ticketstatus");
                    var status = manager2.options[manager2.selectedIndex].value;
                    var manager=document.getElementById("users");
                    var ticketAssignto = manager.options[manager.selectedIndex].value;
                    var manager1=document.getElementById("priority");
                    var priority = manager1.options[manager1.selectedIndex].value;
                    var des = "'"+$scope.ticketdesc+"'"
                    var projectJSON = '{"name" :' + $scope.ticketname +',"id":'+$scope.id+ ',"description" : ' + des + ',"ticketAssignto" : ' + ticketAssignto + ', "token" : ' + sessionToken + ' ,"ticketpriority":' + priority + ' ,"status":' + status + ' ,"startdate":' + $scope.startdate + ' ,"enddate":' + $scope.enddate + '}';
                    $http.post("/trac/ticket", projectJSON)
                            .success(function(data, status, headers, config)
                    {
                      if(data.response.code==200)
                        {
                          $location.path("/view/project/"+$scope.id)
                        }
                        else
                          {
//                            $location.path("/view/saveticket/"+$scope.id)
                            flash.error=data.response.status
                          }
                    })
                .error(function(data, status, headers, config)
        {
            alert("Error" + data.response.error);
        });
    };
         
      }); 
 
   //<!-- updateController end -->  
 
  //<!-- Controller -->  
      trac.controller("Controller", function ($location,$routeParams,$scope,$http){
                 
                 $scope.fetchid=""
             var sessionToken = document.getElementById("token").value;
             $scope.fetchData = function(status,id)
              {
                   
                    $scope.fetchid=id;
                    
                    alert($scope.fetchid);
                    
              }
             $scope.search = function()
                 {
                      
                   $scope.currentPage = 0;
                   $scope.pageSize = 3;
                   var searchString=document.getElementById("q").value;
                   alert(searchString)
                  if(searchString!='')
                    {
                          if(searchString[0]==='#')
                          {
                                  splits = searchString.split('#');
                                  ticketId = splits[1];
                                  $location.path("/view/updateticket/"+ticketId);
                          }
                          else
                          {
                                  var temps1 = new Array();
                                  var count1=0;
                                   var temps2 = new Array();
                                  var count2=0;
                                   var temps3 = new Array();
                                  var count3=0;
                                   $http.get("/trac/search/"+searchString, {  params: { token: sessionToken  }})
                                  .success(function(data,status,headers,config)
                                  {
                                        if(data.response.code==200)
                                        {
                                          $scope.data=data.response.id.length
                                          $scope.numberOfPages=Math.ceil(data.response.id.length/$scope.pageSize);
                                             //alert(searchString);
                                             $location.path("/view/search/"+searchString);
                                               for(var i=0 ; i < data.response.id.length ; i++)
                                              {
                                                  var temp = {"id":data.response.id[i],"name":data.response.name[i],"priority":data.response.priority[i],"projectname":data.response.projectname[i],"description":data.response.description[i],"status":data.response.status[i],"assignTo":data.response.assignTo[i]};
                                                  temps1[count1++]=temp;
                                              }
                                              $scope.datas1 = temps1 ;
                                        }
                                        else
                                        {
                                          flash.error=data.response.status
                                        }
                                  })
                                  .error(function(data,status,headers,config)
                                  {
                                    alert("Hai This is error")
                                      $location.path("/view/ticketlist");
                                  });
                          }
                          }
                          else
                          {
                                  flash('No Ticket found for this Details');
                                  $location.path("/view/ticketlist"); 
                          }
                                          
                };
                $scope.filter = function()
                {
                  this.params = $routeParams;
                  $scope.stats = this.params.status
                  $scope.prios = this.params.priority
                  var statss=$scope.stats;
                  var prioss=$scope.prios;
                  $scope.listticket(statss,prioss)
                }
              
                $scope.listticket = function(status,priority)
                {
                  $scope.currentPage = 0;
                    $scope.pageSize = 3;
                    var temps = new Array();
                    var count=0;
                    var temps1 = new Array();
                    var temps2 = new Array();
                    var temps3 = new Array();
                    var count1=0;
                    var count2=0;
                    var count3=0;
                    $http.get("/trac/ticketsassign?token="+sessionToken,{  params: { ticketstatus: status ,ticketpriority: priority }})
                    .success(function(ytdata) 
                    {
                      
                          if(ytdata.response.code==200)
                          {
                            
                                //alert("This is list ticket");
                                $scope.data=ytdata.response.id.length
                                $scope.numberOfPages=Math.ceil(ytdata.response.id.length/$scope.pageSize);
                                for(var i=0 ; i < ytdata.response.id.length ; i++)
                                {
                                        var temp = {"id":ytdata.response.id[i],"name":ytdata.response.name[i],"currentpriority":ytdata.response.priority[i],"priority":ytdata.response.priority[i],"project":ytdata.response.project[i],"desc":ytdata.response.desc[i],"currentstatus":ytdata.response.status[i],"status":ytdata.response.status[i],"oldstatus":ytdata.response.oldstatus[i],"assignTo":ytdata.response.assignTo[i],"previousassignTo":ytdata.response.assignTo[i]};
                                        temps1[count1++]=temp
                                }
                                $scope.code1 = temps1 
                          }
                    })
                    .error(function(data, status, headers, config)
                    {
                            alert("Error" + data.response.error);
                    });
                }
                 $scope.getTicket = function() //get all tickets method
              {
                    $scope.listticket($scope.ticketstatus,$scope.ticketpriority)
              };
             
             
             $scope.getAllUsers = function() //get all users for a project method
              {
                    $http.get("/trac/projects?token="+sessionToken)
                    .success(function(ytdata) 
                    {
                              $scope.data = ytdata;
                    })
                    .error(function(data, status, headers, config)
                    {
                              
                            alert("Error" + data.response.error);
                    });
              };
              $scope.projectlist = function(name,sdate,stat,edate,opentickets,newtickets,desc,id,manager)
              {
                $scope.status = stat
                $scope.name=name
                $scope.sdate=sdate
                $scope.edate=edate
                $scope.opentickets=opentickets
                $scope.newtickets=newtickets
                $scope.desc=desc
                $scope.id=id
                $scope.manager=manager
              }
              $scope.getProject = function() //get project method
              {
                    $scope.currentPage = 0;
                    $scope.pageSize = 3;
                    var temps = new Array();
                    var counts=0;
                    var temps1 = new Array();
                    var temps2 = new Array();
                    var temps3 = new Array();
                    var count1=0;
                    var count2=0;
                    var count3=0;
                    $http.get("/trac/project?token="+sessionToken)
                    .success(function(ytdata) 
                    {
                       $scope.data=ytdata.response.id.length
                       $scope.numberOfPages=Math.ceil(ytdata.response.id.length/$scope.pageSize);
                          if(ytdata.response.code==200)
                          {
                              for(var i=0 ; i < ytdata.response.id.length ; i++)
                                {
                                   var temp = {"id":ytdata.response.id[i],"name":ytdata.response.name[i],"manager":ytdata.response.manager[i],"opentickets":ytdata.response.opentickets[i],"newtickets":ytdata.response.newtickets[i],"desc":ytdata.response.desc[i],"status":ytdata.response.status[i],"sdate":ytdata.response.sdate[i],"edate":ytdata.response.edate[i]};
                                  temps[counts++]=temp
                                }
                                $scope.codes = temps 
                          }
                    })
                    .error(function(data, status, headers, config)
                    {
                            alert("Error" + data.response.error);
                    });
              };
             $scope.saveProject = function() //save projet method
              {
                    var manager=document.getElementById("users");
                    var ss = manager.options[manager.selectedIndex].value;
                    var projectJSON = '{"name" :' + $scope.projectname + ',"description" : ' + $scope.projectdesc + ', "token" : ' + sessionToken + ',"startdate":'+$scope.startdate+',"enddate":'+$scope.enddate+',"manager":'+ss+'}';
                    $http.post("/trac/project", projectJSON)
                      .success(function(data, status, headers, config)
                      {
                            if ( data.response.code==200)
                              {
                                location.reload();
                               
                              }
                            else
                              {
                                  
                                $location.path("/view/saveproject");
                                flash.error = data.response.status;
                              }
                                                        
                      })
                      .error(function(data, status, headers, config)
                      {
                            alert("Error" + data.response.error);
                      });
                      $location.path("/view/ticketlist");
              };
   
              
    $scope.modifypassword = function()// modify password method to change password by giving current and new password
    {
        var ticketJSON = '{"news":'+$scope.news+',"confirm":'+$scope.newConfirm+',"old":'+$scope.old+',"token":'+sessionToken+'}';
        $http.put("/trac/modify",ticketJSON)
                      .success(function(data,status,headers,config)
                        {
                          
                                   if(data.response.code==200)
                                     {
                                       flash.success=data.response.status;
                                        $location.path("#/view/ticketlist")
                                        flash.success=data.response.status;
                                     }
                                   else
                                     {
                                       flash.error=data.response.status;
                                       $location.path("/view/myaccount")
                                       flash.error=data.response.status;

                                       $scope.old=""
                                       $scope.news=""
                                       $scope.newConfirm=""
                                     }
                        })
                       .error(function(data,status,headers,config)
                        {
                               alert("Error"+data.response.error);
                        });
        
    };

    $scope.updateTickets = function(id,name)//update ticket method
    {
        $scope.first=id
        $scope.second=name
        var token = document.getElementById("rootFolder").value;
        var updateJSON = '{"code" :' + code + ',"token" : ' + token + '}';
        jsons = '{"id":'+id+',"name":'+name+'}';
        $http.get("/trac/ticketupdate", {  params: { id: id , token: token  }
       }).success(function(data,status,headers,config)
       {
                 $scope.temp= data;
                     
        }).error(function(data,status,headers,config){
                        alert("Error"+data.response.error);
        });
    };
         });
         //<!-- Controller end -->  
    </script> 
    <style>
      .dropdown-menu .top-main-manue{width: 100%; height: 40px;}
    </style>


  </body>
</html>