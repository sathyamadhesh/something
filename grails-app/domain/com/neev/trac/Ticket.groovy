package com.neev.trac

class Ticket {

    Status status
     Status oldstatus
    Project project
    User user
    User assignTo
    String name
    String description
    Date dateCreated
    Date lastUpdated
    String priority
    java.sql.Date started
    java.sql.Date enddate
    //PROJECT_ID
    //STATUS_ID
    //USER_ID
    //static hasOne = [status:Status]
    static belongsTo = [user:User,project:Project,status:Status,oldstatus:Status,assignTo:User]
    
    static constraints = {
    }
}
