package com.neev.controller
import grails.converters.*
import groovy.json.JsonBuilder
import com.neev.service.ProjectService
import com.neev.trac.Project
import com.neev.trac.User
import com.neev.trac.Status
import com.neev.trac.Ticket
import com.neev.trac.History
import org.slf4j.Logger
import org.slf4j.LoggerFactory

class HistoryController 
{
    final Logger logger = LoggerFactory.getLogger(HistoryController.class);
    def historyService
    def index() { }
    JsonBuilder jsonbuilder=new JsonBuilder()
    def save()//save history method
    {
        logger.info("in history controller save method")
        def json = request.JSON
        def assignTo = User.findByEmail(json.assignTo)
        if(json.token)
        {
            def token = json.token
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                def statusobj = Status.get(1)
                def projectobj = Project.findByUser(userobj)
                if(projectobj)
                {
                    def ticketobj = Ticket.findByProject(projectobj)
                    if(ticketobj)
                    {
                        def history = new History()
                        history.comment = json.comment
                        history.user = userobj
                        history.status = statusobj
                        history.project = projectobj
                        history.ticket = ticketobj
                        history.priority=priority
                        history.assignTo=assignTo
                        def stat = historyService.save(history)
                        if(stat)
                        {
                            jsonbuilder.response("status":"ok","code":200);
                            render jsonbuilder.toString();
                        }
                        else
                        {
                            jsonbuilder.response("status":"Problem in Saving History","code":401);
                            render jsonbuilder.toString()
                        }
                    }
                    else
                    {
                        jsonbuilder.response("status":"Ticket is Not Available for this project","code":401)
                        render jsonbuilder.toString() 
                    }
                }
                else
                {
                    jsonbuilder.response("status":"No Project is assigned to You","code":401);
                    render jsonbuilder.toString() 
                }
            }
            else
            {
                jsonbuilder.response("status":"Invalid Token","code":401)
                render jsonbuilder.toString() 
            }
        }
        else
        {
            jsonbuilder.response("status":"Token is Not Available","code":401)
            render jsonbuilder.toString()
        }
    }
    def show() //show all history
    {
        logger.info("in history controller show method")
        def token = params.token
        if(token)
        {
            List l=  historyService.show()
            if(l)
            render l as JSON
            else
            {
                jsonbuilder.response("status":"History is Not Available","code":401)
                render jsonbuilder.toString()
            }
                    
        }
        else
        {
            jsonbuilder.response("status":"Token is Not Available","code":401)
            render jsonbuilder.toString()    
        }
    }
    def getById() //show history by id
    {
        logger.info("in history controller get by ticket id method")
        if(params.token)
        {
            def id = params.id
            History history=  historyService.getById(id)
            if(history)
            {
                render history as JSON
            }
            else
            {
                jsonbuilder.response("status":"History is not available","code":401);
                render jsonbuilder.toString()    
            }
             
        }
        else
        {
            jsonbuilder.response("status":"Token is Not Available","code":401);
            render jsonbuilder.toString()    
        }
    }
        
}
