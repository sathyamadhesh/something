<div class="container" style="margin-top:3.3%;margin-left:0%" ng-controller="newController" ng-init="addmembers()">
          <ul class="list-inline">
            <li class="col-md-4"></li>
            <li class="col-md-5 body-boder1">
                    <h3 align="left" style="color:#289EF2">Add Members to the Project</h3>
                      <div flash-alert="error" active-class="in" class="alert fade">
                        <strong class="alert-heading">Boo!</strong>
                        <span class="alert-message">{{flash.message}}</span>
                      </div>
                    <hr style="background:#1df772; border:0; height:1px; " />
                    <input type="hidden" id="rootFolder" name="token"  ng-model="token" value="${token}"/>
                    <form ng-submit="addProjectMembers(code)">
                              <p style="margin-left:3%;">Users*: 
                                    <input list="user" name="user" class="form-control"  ng-model="user" required="">
                                    <datalist id="user" ng-controller="Controller"  ng-init="getAllUsers()">
                                      <option ng-repeat="datas in data" value="{{datas.email}}">{{datas.name}}</option>
                                    </datalist>
                              </p>
                              <p style="margin-left:3%">Designation*:
                                    <select ng-model="role" id="role" class="form-control" required="">
                                          <option value="" style="display:none">Please select</option>
                                          <option  value="Software Developer">Software Developer</option>
                                          <option  value="Test Engineer">Test Engineer</option>
                                          <option  value="Tech Lead">Tech Lead</option>
                                          <option  value="Team Lead">Team Lead</option>
                                          <option  value="Tech Arch">Tech Arch</option>
                                    </select>
                              </p>
                              <p style="margin-left:3%">
                                    <button type="submit" class="btn btn-primary">SUBMIT
                                    </button>
                                <a href="#/view/project/{{code}}"><button style="margin-left: 5%" type="button" class="btn btn-primary">CANCEL</button></a>
                              </p>
                      </form>
              </li> 
            </ul>
</div>