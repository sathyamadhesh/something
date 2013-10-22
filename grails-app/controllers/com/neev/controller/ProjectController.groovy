package com.neev.controller
import grails.converters.*
import groovy.json.JsonBuilder
import com.neev.service.*
import com.neev.trac.*
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.*
import java.text.SimpleDateFormat
import java.text.DateFormat
import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject
class ProjectController 
{
    def ticketService
    def projectService
    def index() { }
    JsonBuilder jsonbuilder=new JsonBuilder()
    final Logger logger = LoggerFactory.getLogger(ProjectController.class);
    
    def save()// method to create project, details of the project is sent to service to save in database
    {
        logger.info("in project controller save project method")
        def json = request.JSON
        if(json.token) //checking for auth token presence in url
        {
            def userobj = User.findByAuthToken(json.token)//find user by auth token
            def statusobj = Status.findByStatus("new") //project during creation in new status
            if(userobj)//checking if user exist
            {
                def project = new Project()
                project.Description = json.description
                project.name = json.name
                def start_date = java.sql.Date.valueOf(json.startdate);
                def end_date = java.sql.Date.valueOf(json.enddate);
                project.user=userobj
                project.status=statusobj
                project.manager=json.manager
                int x=start_date.compareTo(end_date) //validation:comparing start date to end date of project
                def id=User.findByEmail(json.manager) 
                logger.debug("Projectname {}. Description {}.", project.name, project.Description);
                if(!(Project.findByName(project.name)))//checking if project exist by same name
                { 
                    if(x<=0)
                    {
                        project.started = start_date
                        project.enddate = end_date
                        def project1 = projectService.save(project)//calling service to save project
                        if(project1)
                        {
                            logger.info("project saved")
                            def projectMembers=new ProjectMembers()//saving project manager to project members
                            projectMembers.project=project1
                            projectMembers.user=id
                            projectMembers.role="manager"
                            projectMembers.username=id.name
                            if(projectMembers.save())
                            {
                                logger.info("project memebers saved")
                                jsonbuilder.response("status":"ok","code":200)
                                render jsonbuilder.toString()
                            }
                        
                            else
                            {
                                logger.info("project memebers not saved")
                                jsonbuilder.response("status":"pm not saved","code":401)
                                render jsonbuilder.toString()
                            }
                        }
                        else
                        {
                            logger.info("project not saved")
                            jsonbuilder.response("status":"Problem in Saving","code":401)
                            render jsonbuilder.toString()
                        }
                    }
                    else
                    {
                        jsonbuilder.response("status":"project cannot be completed  before it starts","code":401)
                        render jsonbuilder.toString()
                    }

                }  
                else
                {
                    logger.info("project already exists")
                    jsonbuilder.response("status":"project already exists","code":401)
                    render jsonbuilder.toString()
                }
            }
            else
            {
                logger.info("no such user")
                jsonbuilder.response("status":"invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            logger.info("user is not authenticated")
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
           
    }
    def getAllUsers()// fetch all registered users
    {
      
        if(params.token)
        {
            List l = projectService.getAllUsers()
            if(l)
            {
                render l as JSON
            }
            else
            {
                jsonbuilder.response("status":"No User Exists","code":401)
                render jsonbuilder.toString()
            }
            
        }
        else
        {
            jsonbuilder.response("status":"Token not Available","code":401)
            render jsonbuilder.toString()
        }
    }
    def show()//show all projects created
    {
        logger.info("in project controller show project method")
        if(params.token)
        {
            def token = params.token
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                List projectname=  projectService.show(userobj)//fetching projects of the logged in user which returns list of projects
                JSONArray opentickets = new JSONArray();
                JSONArray newtickets = new JSONArray();
                JSONArray statuslist = new JSONArray();
                JSONArray manager = new JSONArray();
                if(projectname)
                {
                    List list=new ArrayList()
                    for (int i = 0; i < projectname.size; i++) //iterating through list
                    {
                        def project=Project.findByName(projectname[i])//find the project and add it to a new list
                        list.add(project)
                              
                    }
                    for(int i=0;i<list.size;i++)
                    {
                        opentickets[i]=ticketService.getAllOpenTickets(list[i].id)//fetch all open tickets for the given project
                        newtickets[i]=ticketService.getAllNewTickets(list[i].id)// fetch all new tickets for the given project
                        def st=Status.get(list[i].status.id)//get status
                        statuslist[i]=st.status//add status to statuslist
                        manager[i]=User.findByEmail(list[i].manager)
                    }
                    //print manager
                    print "jhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhdf"
                    print list
                    JSONArray sdate = new JSONArray(list.started.toString())
                    JSONArray edate = new JSONArray(list.enddate.toString())
                    JSONArray id1 = new JSONArray(list.id);
                    JSONArray desc = new JSONArray(list.description);
                    JSONArray name1 = new JSONArray(list.name);
                    JSONArray manager1 = new JSONArray(manager.name);
                    print manager1
                    jsonbuilder.response("code": 200,"id": id1,"name": name1,"manager": manager1,"opentickets": opentickets,"newtickets":newtickets,"desc":desc,"status":statuslist,"sdate":sdate,"edate":edate);
                    render jsonbuilder.toString();
                }
                else
                {
                    logger.info("No projects to show")
                    jsonbuilder.response("status":"no project is available","code":401)
                    render jsonbuilder.toString()
                }
            }
            else
            {
                logger.info("No such user")
                jsonbuilder.response("status":"invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            logger.info("User is not authenticated")
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    def getById() //get a project object by its id
    {
        logger.info("in project controller GetById project method")
        if(params.token)
        {
            def token = params.token
            def userobj = User.findByAuthToken(token)
            def id = params.id
            if(userobj)
            {
                logger.info("User found")
                Project project=  projectService.getById(id)
                if(project)//if project found for the given id
                {
                    def open = ticketService.getAllOpenTickets(project.id);// get opentickets for the project
                    def news = ticketService.getAllNewTickets(project.id); // get new tickets for the project
                    def managername = User.findByEmail(project.manager)
                    def username = managername.name
                    jsonbuilder.response("code": 200,"id": project.id,"name": project.name,"opentickets": open,"newtickets":news,"desc":project.description,"status":project.status.status,"managermail":project.manager,"managername":username);
                    render jsonbuilder.toString()
                }
                else
                {
                    logger.info("no such project")
                    jsonbuilder.response("status":"requested project is not available","code":401)
                    render jsonbuilder.toString()
                }
            }
            else
            {
                logger.info("token not found")
                jsonbuilder.response("status":"invalid token","code":401)
                render jsonbuilder.toString()
            }
        }
        else
        {
            logger.info("User not authenticated")
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    
    def update() // project update method
    {
        logger.info("in project controller show project method")
      
        def json = request.JSON
        if(json.token)
        {
            logger.info("User authenticated")
            def projectobj = Project.get(json.id)
            def oldmanager = projectobj.manager
            def oldmanager1=User.findByEmail(oldmanager)
            def token = json.token
            def userobj = User.findByAuthToken(token)
            def description=json.description
            def manager=json.manager
            def status = json.status
            print oldmanager1.name + "OOOOOOOOOOOOOOOOOOOOOOOOOO"
            print userobj.name + "NNNNNNNNNNNNNNNNNNNNNNN"
            if(oldmanager1.name == userobj.name)
            {
                if(userobj)
                {
                    if(projectService.update(json.id,description,status,manager,json.edate))
                    {
                        logger.info("project updated")
                        jsonbuilder.response("status":"ok","code":200)
                        render jsonbuilder.toString()
                    }
                    else
                    {
                        logger.info("project not updated")
                        jsonbuilder.response("status":"not updated","code":401)
                        render jsonbuilder.toString()
                    }
                }  
                else
                {
                    logger.info("user not found")
                    jsonbuilder.response("status":"invalid token","code":401)
                    render jsonbuilder.toString()
                }
            }
            else
            {
                logger.info("User not authorized")
                jsonbuilder.response("status":"You are not authorized to change project details","code":401)
                render jsonbuilder.toString()
                
            }
        }
        else
        {
            logger.info("User not authenticated")
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    def getUsersForProject() // get members for given project
    {
        def token = params.token
        def name= params.name
        if(!token)
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
        def userobj = User.findByAuthToken(token)
        if(!userobj)
        {
            jsonbuilder.response("status":"Unauthorized User","code":401)
            render jsonbuilder.toString()
        }
        List list = projectService.getUsersForProject(name) // calling service to get projectmembers which returns list of users
        JSONArray names = new JSONArray();
        JSONArray emails = new JSONArray();
        if(list) 
        {
            
            for(int i=0 ; i< list.size ;i++ )
            {
                def user = User.findByName(list[i])
                emails[i]=user.email
                names[i]=user.name
            }
        
            
            jsonbuilder.response("code": 200,"name": names,"email": emails);
            render jsonbuilder.toString();

        }
        else
        {
            jsonbuilder.response("status":"No List is found with the given Id","code":401)
            render jsonbuilder.toString()
        }
    }
    def getUsersForProjectId() //get users for a project by its id
    {
        def token = params.token
        def id= params.Id
        if(!token)
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
        def userobj = User.findByAuthToken(token)
        if(!userobj)
        {
            jsonbuilder.response("status":"Unauthorized User","code":401)
            render jsonbuilder.toString()
        }
        List list = projectService.getUsersForProjectId(id)// calling service to return list of project members
        JSONArray names = new JSONArray();
        JSONArray emails = new JSONArray();
        if(list)
        
        {
            for(int i=0 ; i< list.size ;i++ )
            {
                def user = User.findByName(list[i])
                names[i]=user.name
                emails[i]=user.email
            }
            
            
            jsonbuilder.response("code": 200,"name": names,"email": emails);
            render jsonbuilder.toString();

        }
        else
        {
            jsonbuilder.response("status":"No List is found with the given Id","code":401)
            render jsonbuilder.toString()
        }
    }

}