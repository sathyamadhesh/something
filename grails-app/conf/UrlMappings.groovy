class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.${format})?"{
           
        }
        "/search/$str"(controller: "ticket", parseRequest: true)
        {
            action = [GET : "search"]
        }
        "/project"(controller: "project", parseRequest: true){
           
            action = [GET: "show", POST: "save"]
        }
        "/projects"(controller: "project", parseRequest: true){
           
            action = [GET: "getAllUsers"]
        }
        "/getUsersForProject"(controller: "project", parseRequest: true){
           
            action = [GET: "getUsersForProject"]
        }
        "/getUsersForProjectId"(controller: "project", parseRequest: true){
           
            action = [GET: "getUsersForProjectId"]
        }
        "/project/$id"(controller: "project", parseRequest: true) 
        {
            action = [ PUT : "update", GET : "getById"]
        }
        "/projectupdate"(controller: "project", parseRequest: true) 
        {
            action = [PUT : "update"]
        }  
        "/ticket"(controller: "ticket", parseRequest: true) 
        {
            action = [GET: "show", POST:"save"]
        }
        "/ticket/$id"(controller: "ticket", parseRequest: true) 
        {
            action = [GET : "getById"]
        }
       "/ticketupdate"(controller: "ticket", parseRequest: true) 
        {
            action = [PUT: "update"]
        }
         "/listticket"(controller: "ticket", parseRequest: true) 
        {
            action = [GET: "getAllTicketsByProject"]
        }
        "/listmembers"(controller: "projectMembers", parseRequest: true) 
        {
            action = [GET: "getAllMembersByProject"]
        }
          "/savemembers"(controller: "projectMembers", parseRequest: true) 
        {
            action = [POST: "save"]
        }
       "/ticketsassign"(controller: "ticket", parseRequest: true) 
        {
            action = [GET : "getAllTicketsByAssignTo"]
        }
        "/modify"(controller: "user", parseRequest: true) 
        {
            action = [PUT : "modifyPassword"]
        }
         "/"(view:"registration")
        "500"(view:'/error')
        
    }
}
