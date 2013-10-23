package com.neev.controller
import com.neev.trac.User
import groovy.util.logging.Slf4j
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import grails.converters.JSON
import java.util.List
import groovy.json.JsonBuilder
class UserController {
    def userService
    final Logger logger = LoggerFactory.getLogger(UserController.class);
    JsonBuilder jsonbuilder=new JsonBuilder()
    
    def addUser() // User registeration, user details has been sent into service to store in database
    {
       
        logger.info("in user controller adduser method")
        def user = new User()
        user.name = params.name //username
        user.email = params.email //user email
        user.password = params.password// user password
        logger.debug("Username {}. Password {}.", user.name, user.password);
        
            if(userService.addUser(user))
            {
                flash.message = "Registered Successfully!!Check Your Mail for a Link to verify Your Account"
                render(view:"/registration")
            }
            else
            {
                flash.message = "Email is alrady there!please give another"
                render(view:"/registration")
            }
    }
  
    def verifyingAccount()// User is verified if the email id is verified or not
    {
        logger.info("in user controller verifying account method")
        def status = userService.verifyingAccount(params.token)
        switch(status)
        {
        case "already verified" : // account is active
            flash.message = "Email is already verified you can now login"
            render(view:"/registration")
            break;
        case "verified Succesfully" : //account is activated
            flash.message = "Email is verified Succesfully you can now login"
            render(view:"/registration")
            break;
        case "user not valid" : //user is not registered
            flash.message = "Invalid User"
            render(view:"/registration")
            break;
        case "invalid Token" : // authentication token does not exist
            flash.message = "Token is invalid"
            render(view:"/registration")
            break;
        default :
            break;
        }
    }
    def signIn()// user sign in method
    {
        logger.info("in user controller signin method")
        def user = new User()
        user.email=params.email //user email
        user.password=params.password //user password
        //logger.debug("Username {}. Password {}.", user.email, user.password);
        def user1 = userService.signIn(user)
        if(user1)
        {
            def date = new Date()
            def tok = userService.md5(user1.email,date) //creation of authentication token for the user to maintain session
            user1.authToken=tok
            user1.save() //updating in database with user authentication token
            //redirect(action:"homepage",controller:"user", params:[token:tok])//rendering homepage on successful login
            response.sendRedirect("/trac/html/homepage.html?token=${tok}");
        }
        else
        {
            flash.message = "Email Id or Password is Incorrect"
            render(view:"/registration") //rendering signin/registeration page if not authenticated
        }
    }
    
    def homepage(){}
    
    def forgotPassword()
    {
        render(view:"/user/enterEmail") //asking user to enter email id when clicked on forgot password
    }
    def reset()//method to get email id from user to send link to reset password
    {
        logger.info("in user controller password reset method")
        def status=userService.reset(params.email) //returns true is email exist and creates forgot password token and is sent to the mail for verification
        if(status)
        {
            flash.message = "Email Has been Sent to Your Mail"
            render(view:"/registration")
        }
        else
        {
            flash.message = "Email is not valid or Account is Not Activated"
            render(view:"/user/enterEmail")
        }
    }
    def changePassword() //method to take new password from user after clicking on forgot password
    {
        logger.info("in user controller change password method")
        def user = userService.changePassword(params.token) //returns true if forgot password token exists
        if(user)
        {
            render(view:"/user/newpassword",model:[email:user.email])
        }
        else
        {
            flash.message = "Token is Invalid for reseting Password"
            render(view:"/registration")
        }
    }
    def update() // sets the usewr with new password
    {
        logger.info("in user controller update user method")
        def status = userService.update(params.email,params.password1,params.password2)
        print params.password1
        print params.password2
        if(status=="SUCCESS")
        {
            flash.message = "You Can Now Login with New Password"
            render(view:"/registration")
        }
        else if(status == "PLP")
        {
            flash.message = "Password Size must be atleast 5 "
            render(view:"/user/newpassword",model:[email:params.email])
        }
        else if(status == "PNM")
        {
            flash.message = "Both Passwords Must Match"
            render(view:"/user/newpassword",model:[email:params.email])
        }
    }
    def modifyPassword() //this method is for changing the password by user.
    {
        logger.info("in user controller modifypassword method")
        def json = request.JSON
        def token=json.token
        User userobj = User.findByAuthToken(token)
        if(userobj&&token)
        {
            def status = userService.modifyPassword(json.old,json.news,json.confirm,userobj)
            if(status)
            {
                jsonbuilder.response("status":"Password id Changed","code":200)
                render jsonbuilder.toString()
            }
            else
            {
                jsonbuilder.response("status":"Problem to change the Password","code":401)
                render jsonbuilder.toString()
            }
        }
    }
    def logout()// make authentication token null to end session
    {
        logger.info("in user controller logout method")
        def token=params.token
        def user=User.findByAuthToken(token)
        if(user)
        {
            user.authToken=null
            user.save()
            render(view:"/registration")
        }
    }
}
