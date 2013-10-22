package com.neev.controller

import com.neev.trac.Project
import com.neev.trac.User
import groovy.json.JsonBuilder
import com.neev.service.ProjectMembersService
import grails.converters.JSON
import com.neev.trac.ProjectMembers



class ProjectMembersController {
    def projectMembersService
    def index() { }
    JsonBuilder jsonbuilder=new JsonBuilder()
    
    def save() // adding project members for a project method
    {
        def json = request.JSON
        def token = json.token
        def user = User.findByEmail(json.email)
        def role = json.role
        def projectid = json.id
        def projectobj = Project.get(projectid)
        def projectmembers=new ProjectMembers()
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            { 
                /*authenticating for user to be a manager to assign members to project*/
                def pm=ProjectMembers.findByUserAndProject(userobj,projectobj)
                if(pm.role=="manager")
                {
                    projectmembers.username=user.name
                    projectmembers.role = role
                    projectmembers.user=user
                    projectmembers.project=projectobj
                    def pms= projectMembersService.save(projectmembers)
                    if(pms)
                    {
                        jsonbuilder.response("status":"ok","code":200)
                        render jsonbuilder.toString()
                    }
                    else
                    {
                        jsonbuilder.response("status":"projectmembers not saved","code":401)
                        render jsonbuilder.toString()
                    }
                    
                }
                else
                {
                    jsonbuilder.response("status":"you dont have rights to add members","code":401)
                    render jsonbuilder.toString()
                }
            }
            else
            {
                jsonbuilder.response("status":"unauthorised user","code":401)
                render jsonbuilder.toString()
            }
           
                
                
        }
        else
        {
            jsonbuilder.response("status":"token not available","code":401)
            render jsonbuilder.toString()
        }
    }
    
    def getAllMembersByProject()//fetch all members belonging to a project
    {
        def token = params.token
        def id=params.id
        if(token)
        {
            def userobj = User.findByAuthToken(token)
            if(userobj)
            {
                def list= projectMembersService.getAllMembersByProject(id)
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
}

