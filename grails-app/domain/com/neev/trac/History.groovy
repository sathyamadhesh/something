package com.neev.trac

class History {
    //TICKET_ID
    //STATUS_ID
    Ticket ticket
    Status status
    Status oldstatus
    User user
    Project project
     User assignTo
     String priority
    String comment
    Date lastUpdated
//    static hasOne = [status : Status]
    static belongsTo = [ticket:Ticket,user:User,status:Status,oldstatus:Status,project:Project]
    static constraints = {
        comment(nullable:true)
    }
}
