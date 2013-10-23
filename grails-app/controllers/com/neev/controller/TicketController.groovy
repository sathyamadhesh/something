package com.neev.controller
import grails.converters.*
import groovy.json.JsonBuilder
import com.neev.trac.Ticket
import com.neev.trac.Project
import com.neev.trac.User
import com.neev.trac.ProjectMembers
import com.neev.trac.Status
import com.neev.trac.History
import com.neev.service.HistoryService
import com.neev.service.ProjectMembersService
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject

class TicketController {
    def historyService
    def ticketService
    def projectMembersService
    def projectService

    def index() { }
    JsonBuilder jsonbuilder=new JsonBuilder()
    final Logger logger = LoggerFactory.getLogger(TicketController.class);

    def save() // save method to add tickets for a project
    {
        logger.info("in Ticket controller save ticket method")
        def json = request.JSON
        def token = json.token
        
        if(token)
        {
            logger.info("token found")
            def userobj = User.findByAuthToken(token)
            def statusobj = Status.findByStatus(json.status)
            def initialstatus=Status.findByStatus("initial")
            def str1=json.name
            def str = Project.get(json.id)
            def projectstartdate=str.started
            def projectenddate=str.enddate
            if(userobj)
            {
                logger.info("User found")
                def ticket = new Ticket()
                ticket.name = json.name
                ticket.description = json.description
                ticket.priority = json.ticketpriority
                def user1 = User.findByEmail(json.ticketAssignto)
                ticket.assignTo = user1
                ticket.user = userobj
                ticket.status = statusobj
                ticket.oldstatus=initialstatus
                ticket.project = str   
                def start_date = java.sql.Date.valueOf(json.startdate);
                def end_date = java.sql.Date.valueOf(json.enddate);    
                int x=start_date.compareTo(end_date) // date comparision to check if start date is lesser than end date
                int y=projectstartdate.compareTo(start_date)
                int z=end_date.compareTo(projectenddate)
                if(x<=0)
                { 
                    if(y<=0 && z<=0)
                    {
                        ticket.started = start_date
                        ticket.enddate = end_date
                        def stat = ticketService.save(ticket)   
                        if(stat)
                        {
                            logger.info("Ticket saved")      
                            def history = new History()//for history updating on ticket creation
                            history.assignTo=user1
                            history.user = userobj
                            history.status = statusobj
                            history.oldstatus=initialstatus
                            history.project = str
                            history.ticket = stat
                            history.priority=json.ticketpriority
                            history.comment = "No Comments"
                            def stat1 = historyService.save(history)
                            if(stat1)
                            {
                                logger.info("Added to Ticket history")
                                jsonbuilder.response("status":"OK","code":200)    
                                render jsonbuilder.toString()
                            }
                            else
                            {
                                jsonbuilder.response("status":"problem in saving history after ticket creation","code":401)    
                                render jsonbuilder.toString()
                            }
                    
                        }
                        else
                        {
                            logger.info("Ticket not saved")      
                            jsonbuilder.response("status":"Problem in Saving","code":401)
                            render jsonbuilder.toString()
                        }        
                    }
                    else
                    {
                        jsonbuilder.response("status":"ticket should be resolved within project duration","code":401)
                        render jsonbuilder.toString()
                    }
                }
                else
                {
                    logger.info("ticket cannot be resolved before it starts")
                    jsonbuilder.response("status":"ticket cannot be resolved before it starts","code":401) 
                    render jsonbuilder.toString()
                }
            } 
            else
            {
            
                logger.info("User not authenticated")
                jsonbuilder.response("status":"User not authenticated","code":401);
                render jsonbuilder.toString()
            }
        }
        else
        {
            logger.info("token not available")
            jsonbuilder.response("status":"token not available","code":401);
            render jsonbuilder.toString()
        }
    }
    def search()
    {
        def token = params.token
        def str = params.str
        if(!token)
        {
             logger.info("token not available")
            jsonbuilder.response("status":"token not available","code":401);
            render jsonbuilder.toString()
        }
        def myuser=User.findByAuthToken(token)
        if(!myuser)
        {
             logger.info("User not authenticated")
             jsonbuilder.response("status":"User not authenticated","code":401);
             render jsonbuilder.toString()
        }
        List ticket=ticketService.search(str)
        if(ticket)
        {
               List status=new ArrayList()
               List user=new ArrayList()
               List projectname=new ArrayList()
               List newticketlist=new ArrayList()
               for(int j=0;j<ticket.size;j++)
               {
                   def project=Project.get(ticket[j].project.id)
                   def member=ProjectMembers.findAllByUserAndProject(myuser,project)
                   if(member)
                     {
                         newticketlist.add(ticket[j])
                     }
                   else
                     {
                           logger.info("no match found")
                           jsonbuilder.response("status":"no match found","code":401);
                           render jsonbuilder.toString()
                     }
                     
               }
               
               for(int i=0;i<newticketlist.size;i++)
               {
                   
                   status.add(newticketlist[i].status.status)
                   user.add(newticketlist[i].assignTo.name)
                   projectname.add(newticketlist[i].project.name)
               }
               JSONArray id=new JSONArray(newticketlist.id)
               JSONArray name=new JSONArray(newticketlist.name)
               JSONArray desc=new JSONArray(newticketlist.description)
               JSONArray priority=new JSONArray(newticketlist.priority)
               JSONArray status1=new JSONArray(status)
               JSONArray userassigned=new JSONArray(user)
               JSONArray project=new JSONArray(projectname)
               jsonbuilder.response("code":200,"id":id,"name":name,"description":desc,"priority":priority,"status":status1,"assignTo":userassigned,"projectname":project);
               render jsonbuilder.toString()
        }
        else
        {
            print "hello hi"
            jsonbuilder.response("status":"no match found","code":401)
            render jsonbuilder.toString()
        }
    }
    def show() // fetch all tickets
    {
        logger.info("in Ticket controller show ticket method")
        def token = params.token
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                List l=  ticketService.show()
                if(l)
                render l as JSON
                else
                {
                    logger.info("No ticket is raised by You")      
                    jsonbuilder.response("status":"No ticket is raised by You","code":401)
                    render jsonbuilder.toString()
                }
            }
            else
            {
                jsonbuilder.response("status":"Invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    def getAllTicketsForAProject() // method to get all tickets raise for a particular project
    {
        logger.info("in Ticket controller get all tickets for a project method")
        def id = params.id
        def token = params.token
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                def list= ticketService.getAllTicketsForAProject(id,userobj) // calling service
                if(list)
                {
                    render list as JSON
                }
                else
                {
                    logger.info("No tickets has been raised for this project")
                    jsonbuilder.response("status":"No List is found with the given Id","code":401)
                    render jsonbuilder.toString()
                }
            
            }
            else
            {
                jsonbuilder.response("status":"Invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    def getById() // get a ticket by its id
    {
        print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        logger.info("in Ticket controller get ticket by its Id method")
        def token = params.token
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            def id = params.id
            if(userobj)
            {
                Ticket ticket=  ticketService.getById(id)// calling service
                if(ticket)
                {
                    List history=historyService.getAllByTicket(ticket)
                    
                    JSONArray cstatus=new JSONArray()
                    JSONArray oldstatus=new JSONArray()
                    JSONArray lastupdatedby=new JSONArray()
                    JSONArray updatedon=new JSONArray()
                    JSONArray comments=new JSONArray()
                    if(history)
                    {
                        
                        for(int i=0;i<history.size;i++)
                        {
                            cstatus[i]=history[i].status.status
                            oldstatus[i]=history[i].oldstatus.status
                            lastupdatedby[i]=history[i].user.name
                            updatedon[i]=history[i].lastUpdated
                            comments[i]=history[i].comment
                        }
                        jsonbuilder.response("code":200,"cstatus":cstatus,"oldstatus":oldstatus,"lastupdatedby":lastupdatedby,"updatedon":updatedon,"comments":comments,"status":ticket.status.status,"id":ticket.id,"name":ticket.name,"assignTo":ticket.assignTo.name,"assignemail":ticket.assignTo.email ,"description":ticket.description,"priority":ticket.priority,"projectname":ticket.project.name);
                        render jsonbuilder.toString()
                    }
                    else
                    {
                        jsonbuilder.response("status":"some problem in fetching history","code":401 );        
                        render jsonbuilder.toString()
                    }
                }
                else
                {
                    logger.info("ticket not found with this Id")
                    jsonbuilder.response("status":"ticket is not available by this account","code":401)
                    render jsonbuilder.toString()
                }
            }
            else
            {
                jsonbuilder.response("status":"Invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    def getAllTicketsByUser() //fetch tickets raised by logged in user
    {
        logger.info("in Ticket controller Get all tickets created by user method")
        def token = params.token
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                def list= ticketService.getAllTicketsByUser(userobj)
                if(list)
                {
                    render list as JSON
                }
                else
                {
                    jsonbuilder.response("status":"No List is found with the given Id","code":401)
                    render jsonbuilder.toString()
                }
            
            }
            else
            {
                jsonbuilder.response("status":"Invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    def getAllTicketsByProject()// fetch all tickets for a particular project
    {
        logger.info("in Ticket controller Get all tickets for a particular project")
        def token = params.token
        def id=params.id
        
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                List list= ticketService.getAllTicketsByProject(id)//calling service
                JSONArray project1 = new JSONArray();
                JSONArray status1 = new JSONArray();
                JSONArray oldstatus1 = new JSONArray();
                JSONArray userassigned = new JSONArray();
                if(list)
                {
             
                    for (int i = 0; i < list.size; i++) 
                    {
                        project1[i]=list[i].project.name
                        userassigned[i]=list[i].assignTo.name
                        oldstatus1[i]=list[i].oldstatus.status
                        status1[i]=list[i].status.status
                    }
                 
                    JSONArray id1 = new JSONArray(list.id);
                    JSONArray desc = new JSONArray(list.description);
                    JSONArray name1 = new JSONArray(list.name);
                    JSONArray priority = new JSONArray(list.priority);
                    print "oldstatus ***************"+oldstatus1
                    
              
                    jsonbuilder.response("code": 200,"id": id1,"name": name1,"priority": priority,"project":project1,"desc":desc,"status":status1,"oldstatus":oldstatus1,"assignTo":userassigned);
                    render jsonbuilder.toString();              
                }
                else
                {
                    jsonbuilder.response("status":"No List is found with the given Id","code":401)
                    render jsonbuilder.toString()
                }
            
            }
            else
            {
                jsonbuilder.response("status":"Invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    def getAllTicketsByAssignTo() // fetch all tickets assigned to the logged in user
    {
        logger.info("in Ticket controller get all tickets assigned to user method")
        print params.ticketstatus
        print params.ticketpriority
        def token = params.token
        
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                List list= ticketService.getAllTicketsByAssignTo(userobj,params.ticketstatus,params.ticketpriority)
                print list
                JSONArray project1 = new JSONArray();
                JSONArray status1 = new JSONArray();
                 JSONArray oldstatus1 = new JSONArray();
                JSONArray userassigned = new JSONArray();
                if(list)
                {
                    for (int i = 0; i < list.size; i++) 
                    {
                        status1[i]=list[i].status.status  
                        oldstatus1[i]=list[i].oldstatus.status
                        project1[i]=list[i].project.name
                        userassigned[i]=list[i].assignTo.name  
                    }
                   
                    JSONArray id1 = new JSONArray(list.id);
                    JSONArray desc = new JSONArray(list.description);
                    JSONArray name1 = new JSONArray(list.name);
                    JSONArray priority = new JSONArray(list.priority);
                    print "oldstatus ***************"+oldstatus1
                    jsonbuilder.response("code": 200,"id": id1,"name": name1,"priority": priority,"project":project1,"desc":desc,"status":status1,"oldstatus":oldstatus1,"assignTo":userassigned);
                    render jsonbuilder.toString();
                }
                else
                {
                    jsonbuilder.response("status":"No List is found with the given Id","code":401)
                    render jsonbuilder.toString()
                }
            
            }
            else
            {
                jsonbuilder.response("status":"Invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    
    def getAllNewTickets()// get all new tickets for a particular project by its id
    {
        
        def asd = params
        def json=request.JSON
        def token = asd.token
        def id=asd.id
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                def newticketlist= ticketService.getAllNewTickets(id)
                if(newticketlist)
                {
                    jsonbuilder.response("status":"success","code":newticketlist)
                    render jsonbuilder.toString()
                           
                }
                else
                {
                    jsonbuilder.response("status":"No new ticket List is found with the given Id","code":0)
                    render jsonbuilder.toString()
                }
            }
            else
            {
                jsonbuilder.response("status":"Invalid token","code":401)
                render jsonbuilder.toString() 
            }
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    
    
    
    def getAllOpenTickets() //get all open tickets by project id
    {
        def asd = params
        def json=request.JSON
        def token = asd.token
        def id=asd.id
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                def openticketlist= ticketService.getAllOpenTickets(id)
                if(openticketlist)
                {
                    
                       
                    jsonbuilder.response("status":"success","code":openticketlist)
                    render jsonbuilder.toString()
                       
                }
                else
                {
                    jsonbuilder.response("status":"No new ticket List is found with the given Id","code":0)
                    render jsonbuilder.toString()
                }
            }
            else
            {
                jsonbuilder.response("status":"Invalid token","code":401)
                render jsonbuilder.toString() 
            }
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    
    def getAllTicketsByAssignToProject()//get all tickets for a user assigned to him for a project
    {
        logger.info("in Ticket controller get all tickets assigned to user for a project method")
        def token = params.token
        def projectid=params.id
        def projectobj=Project.get(projectid)
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                if(projectobj.user==userobj)
                {
                    def list= ticketService.getAllTicketsByAssignToProject(projectobj,userobj)
                    if(list)
                    {
                        render list as JSON
                    }
                    else
                    {
                        jsonbuilder.response("status":"No List is found with the given Id","code":401)
                        render jsonbuilder.toString()
                    }
                }
            }
            else
            {
                jsonbuilder.response("status":"Invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    
 
    def update()// ticket update method
    {
        logger.info("in Ticket controller update project method")
        def json = request.JSON
        print "Token*****************************"
        def token = json.token
        print "priority******************************"
        print json.priority
        print "status*********************************"
        print json.status
        print "oldstatus**********************"
        print json.oldstatus
        print "projectname************************"
        print json.projectname
        print "assignTo************************"
        print json.assignTo
        print "comment******************"
        print json.comment
        print "id*******************"
        print json.id
        print "assigns*****************"
        print json.assigns
        print "Completed"
        
        def assigns=json.assigns
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            def id = json.id
            def priority=json.priority
            def status=json.status
            def oldstatus=json.oldstatus
            println("gfvvvvvvvvvvvvvvvvvvvvvvvvvvvv")
            println(oldstatus)
            def assignTo = User.findByName(json.assignTo)
            if(userobj)
            {
                ProjectMembers projectmembers =ProjectMembers.findByUser(userobj)
                if(projectmembers.user==userobj)
                {
                    if(ticketService.update(id,assignTo,priority,status,oldstatus,assigns) )//calling service to ticket update
                    {
                        logger.info("ticket updated")
                        def history = new History()//for history updating
                        def statusobj = Status.findByStatus(status)
                        def initialstatus = Status.findByStatus(oldstatus)
                        def projectobj = Project.findByName(json.projectname)
                        def ticketobj = Ticket.get(id)
                        history.assignTo=assignTo
                        history.comment = json.comment
                        history.user = userobj
                        history.status = statusobj
                        history.oldstatus = initialstatus
                        history.project = projectobj
                        history.ticket = ticketobj
                        history.priority = priority
                        def stat = historyService.save(history)
                        if(stat)
                        {
                            logger.info("Added to Ticket history")
                            jsonbuilder.response("status":"OK","code":200)    
                            render jsonbuilder.toString()
                        }
                    }
                    else
                    {
                        logger.info("ticket not updated")
                        jsonbuilder.response("status":"Update Failed","code":401)    
                        render jsonbuilder.toString()
                    }
                }
                else
                {
                    jsonbuilder.response("status":"Invalid Token","code":401)
                    render jsonbuilder.toString()    
                }
            }
        }
        else
        {
            jsonbuilder.response("status":"Token is not available","code":401)
            render jsonbuilder.toString()    
        }
    }
}