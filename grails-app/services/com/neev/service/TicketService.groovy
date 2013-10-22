package com.neev.service
import grails.transaction.Transactional
import com.neev.trac.Ticket
import com.neev.trac.Project
import com.neev.trac.History
import com.neev.trac.Status
import org.slf4j.Logger
import org.slf4j.LoggerFactory
@Transactional
class TicketService 
{
    final Logger logger = LoggerFactory.getLogger(TicketService.class);
    def serviceMethod() {}
    def save(def ticket) //save ticket service
    {
        logger.info("in Ticket Service save ticket method")
        if(ticket.save(flush:true))
        {
            logger.info("ticket saved and mail sent")
            sendMail{
                to "${ticket.assignTo.email}"
                subject "Regarding assignment of a ticket"
                body "You are getting this email since a ticket has been assigned to you"
            }
            return ticket
        }
        else
        {
            ticket.errors.each{print it}
            return null
        }
        
    }
    def search(def str)
    {
        List strings=Ticket.findAll()
         List l=new ArrayList()
        for (int i = 0; i < strings.size; i++) 
        {
            String names= strings[i].name;
            boolean b1 = names.toLowerCase().contains(str.toLowerCase())
            def description=strings[i].description;
            boolean b2 = description.toLowerCase().contains(str.toLowerCase())
            if(b1==true || b2==true)
            {
                l.add(strings[i]);
            }
            
        }
        return l
    }
    def show() //get all tickets service
    {
        logger.info("in Ticket Service show all ticket method")
        List list=Ticket.list()
        if(list)
        return list
        else
        return null
    }
    def getById(def id)//get ticket by its id service
    {
        logger.info("in Ticket Service get by ticket id method")
        def ticket=Ticket.get(id)
        if(ticket)
        return ticket
        else
        return null
    }
    def getAllTicketsByUser(def userobj) //get tickets created by a user service
    {
        logger.info("in Ticket Service get all tickets raised by user method")
        List ticket = Ticket.findAllByUser(userobj)
        if(ticket)
        return ticket
        else
        return null
    }
    def getAllTicketsByAssignTo(def userobj,def status,def priority) //get tickets assigned to a user
    {
        logger.info("in Ticket Service get all tickets assigned to user method")
        def statusobj=Status.findByStatus(status)
        def ticket=null
        if(status=="all" && priority=="all")
        {
         ticket = Ticket.findAllByAssignTo(userobj)
        }
        else if(status=="all")
        {
         ticket=Ticket.findAllByAssignToAndPriority(userobj,priority)
        }
        else if(priority=="all")
        {
         ticket=Ticket.findAllByAssignToAndStatus(userobj,statusobj)
        }
        else
        {
         ticket=Ticket.findAllByAssignToAndPriorityAndStatus(userobj,priority,statusobj)
        }
        if(ticket)
        {
            print ticket+"SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS";
            return ticket
        }
        else
        return null
    }
    def getAllNewTickets(def id) //get all new tickets for a project
    {
        
        def status=Status.findByStatus("new")
        def project=Project.get(id)
        List newticketlist=Ticket.findAllByProjectAndStatus(project,status)
        if(newticketlist){
            return newticketlist.size()
        }
        else
        return 0
    }
    def getAllOpenTickets(def id) //get all open tickets for a project
    {
       
        def status=Status.findByStatus("in progress")
        def project=Project.get(id)
       
        List openticketlist=Ticket.findAllByProjectAndStatus(project,status)
       
        if(openticketlist){
            return openticketlist.size()
        }
        else
        return 0
    }
    def getAllTicketsByAssignToProject(def projectobj,def userobj)// get all tickets assign to user for a project
    {
        logger.info("in Ticket Service get all tickets for a project method")
        def ticket = Ticket.findAllByAssignToAndProject(userobj,projectobj)
        if(ticket){
            return ticket
        }
        else
        return null
    }
  
    def getAllTicketsByProject(def id )//get all tickets for a project
    {
        logger.info("in Ticket Service get all tickets for a project method")
        def project =Project.get(id)  
        if(project)
        {
            List list = Ticket.findAllByProject(project)
            if(list)
            return list
            else
            return null
        }
        else
        return null
    }
    def update(def id,def assignTo,def priority,def status,def oldstatus,def assigns) //update ticket service
    { 
        logger.info("in Ticket Service update ticket method")
        def ticket= Ticket.get(id)
        def statusobj = Status.findByStatus(status)
        ticket.priority=priority
        ticket.status=statusobj
        ticket.oldstatus=Status.findByStatus(oldstatus)
        ticket.assignTo=assignTo
        try
        {
            if(assigns!=assignTo.email)
            {
                    sendMail
                    {
                    
                            to "${ticket.assignTo.email}"
                            subject "Regarding assignment of a ticket with updations"
                            body "You are getting this email since a ticket has been assigned to you"
                    }
            }
            ticket.save(flush:true);
            return ticket
        }
        catch(Exception e)
        {
            e.printStackTrace()
        }
    }
    def getAllTicketsForAProject(def id,def userobj)//get tickets to user for a project
    {
        logger.info("in Ticket Service get all tickets for a project method")
        def project =Project.get(id)  
        if(project)
        {
            List list = Ticket.findAllByUserAndProject(userobj,project)
            if(list)
            return list
            else
            return null
        }
        else
        return null
    }
}