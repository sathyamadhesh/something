$(document).ready(function() {
    $(".datepicker1").datepicker();
});
$(document).ready(function(){
  $("#bar1").click(function(){
    
    $("#div2").hide().delay( 200 );
    $("#div3").hide().delay( 200 );
    $("#div4").hide().delay( 200 );
    $("#div5").hide().delay( 200 );
    $("#div6").hide().delay( 200 ); 
    $("#div7").hide().delay( 200 );
    $("#div8").hide().delay( 200 ); 
    $("#div1").show("slow");
    
  });
});
$(document).ready(function(){
  $("#bar2").click(function(){
    $("#div3").hide().delay( 200 );
    $("#div1").hide().delay( 200 ); 
    $("#div4").hide().delay( 200 ); 
    $("#div5").hide().delay( 200 );  
    $("#div6").hide().delay( 200 );  
    $("#div7").hide().delay( 200 );
    $("#div8").hide().delay( 200 );
    $("#div2").show("slow");

  });
});
$(document).ready(function(){
  $("#bar4").click(function(){
    
    $("#div2").hide().delay( 200 );
    $("#div3").hide().delay( 200 );
    $("#div1").hide().delay( 200 );
    $("#div5").hide().delay( 200 );
    $("#div6").hide().delay( 200 ); 
    $("#div7").hide().delay( 200 );
    $("#div8").hide().delay( 200 ); 
    $("#div4").show("slow");
    
  });
});
$(document).ready(function(){
  $("#nt").click(function(){
    $("#div2").hide().delay( 200 );
    $("#div1").hide().delay( 200 ); 
    $("#div4").hide().delay( 200 );  
    $("#div5").hide().delay( 200 ); 
    $("#div6").hide().delay( 200 ); 
    $("#div7").hide().delay( 200 );
    $("#div8").hide().delay( 200 ); 
    $("#div3").show("slow");

  });
});

$(document).ready(function(){
  $("#vt").click(function(){
    $("#div2").hide().delay( 200 );
    $("#div1").hide().delay( 200 ); 
    $("#div3").hide().delay( 200 );
    $("#div5").hide().delay( 200 );    
    $("#div6").hide().delay( 200 );
    $("#div7").hide().delay( 200 ); 
    $("#div8").hide().delay( 200 );
    $("#div4").show("slow");

  });
});
$(document).ready(function(){
  $("#wt").click(function(){
    $("#div2").hide().delay( 200 );
    $("#div1").hide().delay( 200 ); 
    $("#div3").hide().delay( 200 );   
    $("#div4").hide().delay( 200 ); 
    $("#div6").hide().delay( 200 );
    $("#div7").hide().delay( 200 ); 
    $("#div8").hide().delay( 200 );
    $("#div5").show("slow");

  });
});
$(document).ready(function(){
  $("#np").click(function(){
    $("#div2").hide().delay( 200 );
    $("#div1").hide().delay( 200 ); 
    $("#div3").hide().delay( 200 );   
    $("#div4").hide().delay( 200 ); 
    $("#div5").hide().delay( 200 ); 
    $("#div7").hide().delay( 200 ); 
    $("#div8").hide().delay( 200 );
    $("#div6").show("slow");

  });
});
$(document).ready(function(){
  $("#vp").click(function(){
    $("#div2").hide().delay( 200 );
    $("#div1").hide().delay( 200 ); 
    $("#div3").hide().delay( 200 );   
    $("#div4").hide().delay( 200 ); 
    $("#div5").hide().delay( 200 ); 
    $("#div6").hide().delay( 200 ); 
    $("#div8").hide().delay( 200 ); 
    $("#div7").show("slow");
  });
});
$(document).ready(function(){
  $("#wp").click(function(){
    $("#div2").hide().delay( 200 );
    $("#div1").hide().delay( 200 ); 
    $("#div3").hide().delay( 200 );   
    $("#div4").hide().delay( 200 ); 
    $("#div5").hide().delay( 200 ); 
    $("#div6").hide().delay( 200 ); 
    $("#div7").hide().delay( 200 ); 
    $("#div8").show("slow");
  });
});
$(document).ready(function(){
$('.numbersOnly').keyup(function () {
    if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
       this.value = this.value.replace(/[^0-9\.]/g, '');
    }
});
});

function CreateCtrl($scope,$http) 
{
    $scope.save = function() 
    {
          var project = "name" +$scope.json1 + "description" + $scope.json2 + "token" + $scope.json3
          $http.post("/trac/project",project)
                .success(function(data,status,headers,config)
                {
                    alert(data.response.code);
                })
                .error(function(data,status,headers,config)
                {
                    alert("Error"+data);
                });
  
  }
}


