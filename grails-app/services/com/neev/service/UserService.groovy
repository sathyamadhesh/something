package com.neev.service
import java.security.MessageDigest
import grails.transaction.Transactional
import com.neev.trac.User
import org.slf4j.Logger
import org.slf4j.LoggerFactory


@Transactional
class UserService {
final Logger logger = LoggerFactory.getLogger(UserService.class);
    def serviceMethod() 
    {

    }
   
    def addUser(User user) // user data is saved into database, returns true on successful saving
    {
        logger.info("in user Service adduser method")
        def user1=User.findByEmail(user.email)
        if(!user1)
        {
            user.status = "inactive"
            def hashCode = md5(user.email,user.name)
            user.token = hashCode
            user.password = md5(user.password)
            if(!(user.save()))
            {
                 logger.info("User not saved")
                user.errors.each{print it}
            }
            else
            {
                 logger.info("User saved and sent mail")
                sendMail{
                    to "${user.email}"
                    subject "Verification URL"
                    body "Use This Verification URL to activate your account http://10.132.161.244:8080/trac/user/verifyingAccount?token=${hashCode}"
                }
                return true
            }
        }
        else
        return false
    
    }
  
    def md5(def email,def name)//creating user token by hashing username and email
    {
        def digest = MessageDigest.getInstance("MD5")
        def text = "${email} ${name}"
        String md5hash1 = new BigInteger(1,digest.digest(text.getBytes())).toString(16).padLeft(32,"0")
         logger.debug("Hascode", md5hash1);
        return md5hash1
    }
    def md5(def password) // creating encrypted password 
    {
        def digest = MessageDigest.getInstance("MD5")
        def text = "${password}"
        String md5hash1 = new BigInteger(1,digest.digest(text.getBytes())).toString(16).padLeft(32,"0")
       logger.debug("Hascode for password", md5hash1);
        return md5hash1
    }
    def verifyingAccount(String token)// user account verification method
    {
         logger.info("in user service verifying account method")
        if(token)
        {
            def user = User.findByToken(token)
            if(user)
            {
                if(user.status == "ACTIVE")//checking if account is active
                {
                    logger.info("user already active")
                    return "already verified"
                }
                else //changing user status from inactive to active
                {
                    logger.info("user verified thru email")
                    user.setStatus("ACTIVE")
                    user.save()
                    return "verified Succesfully"
                }
            }
            else
            {
                return "user not valid"
            }
        }
        else
        {
            return "invalid Token"
        }
        
    }
    def signIn(User user)//User authentication
    {
        logger.info("in user service signin method")
        def user1 = User.findByEmail(user.email)
        if(user1)
        {
            def passwd = md5(user.password)
            if(user1.password == passwd)//checking if passwords match
            {
                logger.info("user authenticated")
                return user1
            }
            else
            {
                return false
            }
        }
        else
        {
            return false
        }
    }
    
    def reset(def email)
    {
        logger.info("in user service reset method")
        def user = User.findByEmail(email)
        def date = new Date()
        def hashcode = md5(email,date)
        if(user && user.status=="ACTIVE")
        {
            sendMail
            {
                to "${email}"
                subject "Password Reset Link"
                body "Use This URL to Reset Your Password http://10.132.161.244:8080/trac/user/changePassword?token=${hashcode}"
            }
            user.forgotPasswordToken = hashcode
            user.save()
            return true
        }
        else
        {
            return false
        }
    }
    
    def changePassword(def token)
    {
        logger.info("in user service change password method")
        if(token)
        {
            def user = User.findByForgotPasswordToken(token)
            if(user)
            {
                user.forgotPasswordToken = null
                user.save()
                return user
            }
            else
            {
                return null
            }
        }
    }
    def update(def email,def password,def password2)// updating the new password when clicked on forgot password
    {
        if(password==password2)
        {
            print password + "####################"
            print password2 + "###################"
            logger.info("in user service  user update method")
            def user = User.findByEmail(email)
            String pwd=password
            if(user)
            {
                if(pwd.length()>=5)
                {
                    def passwd = md5(password)
                    user.password = passwd
                    user.save()
                    return "SUCCESS"
                    logger.info("password updated")
                }
                else
                {
                    return "PLP"
                }
            }
        }
        else
        {
            return "PNM"
        }
        
        
    }
    def modifyPassword(def old, def newp, def confirmp,def userobj)//changing password by user,by providing the current and new password
    {
        logger.info("in user service modify password method")
        if(newp==confirmp)
        {
            def hash = md5(old)
            def hash1 = md5(newp)
            if(userobj.password==hash)
            {
                def user = User.findByEmail(userobj.email)
                user.password=hash1
                user.save()
                logger.info("password modified")
                return true
            }
            else
                return false
        }
        else
        {
            return false
        }
        
    }
}

