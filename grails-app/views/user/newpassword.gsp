<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
    <script type="text/javascript">
      function ValidateUserRecord() 
      {
    //alert("Hi");
    var userpassword1;
    var userpassword2;
    userpassword1 null;
    userpassword2 null;
    userpassword1 = $('#signInPassword1').val();
    userpassword2 = $('#signInPassword2').val();
    if((userpassword1 == null )||(userpassword2 == null ) )
    {
        $('#signInPassword1').focus();
        $('#lblError').css('display','block');
        $('#lblError').text('Password field is required.');
        return false;
    }
    else if((userpassword1.length == 0))
    {
      $('#signInPassword1').focus();
        $('#lblError').css('display','block');
        $('#lblError').text('Password Length Must Be atleast 5');
        return false;
    }
    else if((userpassword2.length == 0))
    {
      $('#signInPassword1').focus();
        $('#lblError').css('display','block');
        $('#lblError').text('Password Length Must Be atleast 5');
        return false;
    }
    else if(userpassword1 != userpassword2)
    {
        $('#signInPassword2').focus();
        $('#lblError').css('display','block');
        $('#lblError').text('Password is Not Matched');
        return false;
    }
    
   
}
  
      $(document).ready(function(){
  setTimeout(function(){
  $(".flash").fadeOut("slow", function () {
  $(".flash").remove();
      }); }, 2000);
    </script>
    <style type="text/css">  
      .flash{
        width:759px;
        padding-top:8px;
        padding-bottom:8px;
        background-color: #fff;
        font-weight:bold;
        font-size:20px;-moz-border-radius: 6px;-webkit-border-radius: 6px;
      }
      .co1
      {
        background-color:#06293F;
      }
      
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sample title</title>
  </head>
  <body>
    <div class="container" style="margin-top:5%">
    <h1>Enter Your New Password</h1>
    <g:form action="update" controller="user"  onsubmit="return ValidateUserRecord();">
      <input type="hidden" name="email" value="${email}">
      <p class="col-md-5" style="margin-top:2%;">
        <input id="signInPassword1" type="password" name="password1" class="form-control" required="">
        <input id="signInPassword2" type="password" name="password2" class="form-control" required="">
      </p>
      <p class="col-md-5" style="margin-top:2%;"><button type="submit" class="btn btn-primary">EnterPassword</button></p>
    </g:form>
    </div>
   <div class="flash">
              ${flash.message}
  </div>
  </body>
</html>
