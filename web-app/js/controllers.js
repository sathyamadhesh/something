function Controller($scope, $http)
{
    $scope.getProject = function()
    {
        var token = document.getElementById("rootFolder").value;
        $http.get("/trac/project?token="+token)
         .success(function(ytdata) 
         {
//             $scope.new = $scope.getNewTicket();
//             $scope.open = $scope.getOpenTicket();
             $scope.data = ytdata;
         })
         .error(function(data, status, headers, config)
         {
             alert("helllooooooooo");
               alert("Error" + data.response.status);
         });
    };
    $scope.saveProject = function()
    {
        alert($scope.projectname);
        var token = document.getElementById("rootFolder").value;
        alert($scope.projectname);
        var projectJSON = '{"name" :' + $scope.projectname + ',"description" : ' + $scope.projectdesc + ', "token" : ' + token + '}';
        alert(projectJSON);
        $http.post("/trac/project", projectJSON)
                .success(function(data, status, headers, config)
        {
           
            alert(data.response.code);
        })
                .error(function(data, status, headers, config)
        {
            alert("Error" + data);
        });
    };
    $scope.saveTicket = function()
    {
        var token = document.getElementById("rootFolder").value;
//      var doc = angular.element(document.documentElement);
//      $scope.token = doc.find('input').rootFolder.val();
        var projectJSON = '{"name" :' + $scope.projectname + ',"description" : ' + $scope.ticketdesc + ',"ticketAssignto" : ' + $scope.ticketAssignto + ', "token" : ' + token + ', "ticketname" : ' + $scope.ticketname + ' ,"ticketpriority":' + $scope.ticketpriority + '}';
        alert(projectJSON);
        $http.post("/trac/ticket", projectJSON)
                .success(function(data, status, headers, config)
        {
            alert(data.response.code);
        })
                .error(function(data, status, headers, config)
        {
            alert("Error" + data.response.status);
        });
    };
    $scope.getTicket = function()
    {
        var token = document.getElementById("rootFolder").value;
        $http.get("/trac/ticketsassign?token="+token)
         .success(function(ytdata) 
         {
             $scope.data = ytdata;
         })
         .error(function(data, status, headers, config)
         {
             alert("helllooooooooo");
               alert("Error" + data.response.status);
         });
    };
    $scope.getNewTicket = function()
    {
        var token = document.getElementById("rootFolder").value;
        $http.get("/trac/ticketsnew?token="+token)
         .success(function(ydata) 
         {
             $scope.data = ydata.response.code;
             var data1=$scope.data;
         })
         .error(function(data, status, headers, config)
         {
             alert("helllooooooooo");
               alert("Error" + data.response.status);
         });
    };
    
      $scope.getOpenTicket = function()
    {
        var token = document.getElementById("rootFolder").value;
        $http.get("/trac/ticketsopen?token="+token)
         .success(function(ydata) 
         {
             $scope.data = ydata.response.code;
         })
         .error(function(data, status, headers, config)
         {
             alert("helllooooooooo");
               alert("Error" + data.response.status);
         });
    };
    $scope.updateTicket = function(id,name)
    {
        alert("hi");
        alert(id);
        alert(name);
        var token = document.getElementById("rootFolder").value;
        var updateJSON = '{"code" :' + code + ',"token" : ' + token + '}';
        $http.get("/trac/ticketupdate", {  params: { id: id , token: token  }
       }).success(function(data,status,headers,config){
                   $scope.temp= data;
	}).error(function(data,status,headers,config){
			alert("Error"+data);
	});

//        $http.get("/trac/ticketupdate", updateJSON)
//         .success(function(ytdata) 
//         {
//             $scope.data = ytdata;
//         })
//         .error(function(data, status, headers, config)
//         {
//             alert("helllooooooooo");
//               alert("Error" + data.response.status);
//         });
    };
}


