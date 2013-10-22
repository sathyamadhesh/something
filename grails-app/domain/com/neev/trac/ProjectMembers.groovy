package com.neev.trac

class ProjectMembers {
    Project project
    User user
    String role
    String username
 static belongsTo = [project:Project,user:User]
    static constraints = {
    }
}
