package com.neev.service

import grails.transaction.Transactional
import com.neev.trac.ProjectMembers
import com.neev.trac.Project
@Transactional
class ProjectMembersService {

    def save(def projectmembers)//add project members service
    {
       
        if(!projectmembers.save())
        {
            projectmembers.errors.each{print it}
            return false
        }
        else
        return true

    }
    def getAllMembersByProject(def id) //get all project members for a project
    {
        def project = Project.get(id)
        List projectmemberslist = ProjectMembers.findAllByProject(project)
        if(projectmemberslist)
        {
            return projectmemberslist
        }
        else
        {
            return null
        }
    }
}
