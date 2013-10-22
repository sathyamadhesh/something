package com.neev.service

import grails.transaction.Transactional
import com.neev.trac.Project
import com.neev.trac.User
import com.neev.trac.ProjectMembers
import com.neev.trac.Status
import org.slf4j.Logger
import org.slf4j.LoggerFactory
@Transactional

class ProjectService {
    final Logger logger = LoggerFactory.getLogger(ProjectService.class);
    def serviceMethod() {}
 

    def save(def project)// service method to save project into database
    {
        logger.info("in project service save project method")
      
        if(!(project.save()))
        {
            logger.info("project not saved")
            project.errors.each{print it}
            return false
        }
        else
        return project
    }
    def show(def userobj)// show method to show all projects to user
    {
        logger.info("in project service show all project by user method")
        List list=ProjectMembers.findAllByUser(userobj)
        if(list)
        {
            List list1=new ArrayList()
            for(int j=0;j<list.size;j++)
            {
                list1.add(list[j].project.name)
            }
            List l=new ArrayList()
            l.add(list1[0])
            for(int i=1;i<list1.size;i++)
            { 
                if(!(l.contains(list1[i])))
                l.add(list1[i])
            }
            return l    // returns list to controller
        }
        
        
        else
        return null
    }
    def getAllUsers() // service method to fetch all registered users
    {
        List l = User.findAll()
        if(l)
        {
            return l
        }
        else
        return null
         
    }
    def getById(def id) // get a project by its id service
    {
        logger.info("in project service show project by id method")
        def project=Project.get(id)
        if(project)
        return project
        else
        return null
    }
   
    def update(def id,def description,def status,def manager,def edate) // update project service
    {
        logger.info("in project service update project by id method")
        def project= Project.get(id)
        def statusobj = Status.findByStatus(status)
        project.status = statusobj
        project.Description = description
        project.enddate=java.sql.Date.valueOf(edate);
        project.manager=manager
        if(project.save()) //saving with updated data
        return true
        else
        {
            project.errors.each{print it}
            return null    
        }
        
    }
    def getUsersForProject(def name) // get all users assigned to a project
    {
        def project = Project.findByName(name)
        List l1 = ProjectMembers.findAllByProject(project)
        if(l1)
        {
            List list1=new ArrayList()
            for(int j=0;j<l1.size;j++)
            {
                list1.add(l1[j].username)
            }
            List l=new ArrayList()
            l.add(list1[0])
            for(int i=1;i<list1.size;i++)
            { 
                if(!(l.contains(list1[i])))
                l.add(list1[i])
            }
            return l
        }
        else
        return null
    }
    def getUsersForProjectId(def id)// get all users for a project by its id
    {
        def project = Project.get(id)
        print "This is id ********************************************"
        List l1 = ProjectMembers.findAllByProject(project)
        if(l1)
        {
            List list1=new ArrayList()
            for(int j=0;j<l1.size;j++)
            {
                list1.add(l1[j].username)
            }
            List l=new ArrayList()
            l.add(list1[0])
            for(int i=1;i<list1.size;i++)
            { 
                if(!(l.contains(list1[i])))
                l.add(list1[i])
            }
            return l
        }
        else
        return null
    }
}

    
    

