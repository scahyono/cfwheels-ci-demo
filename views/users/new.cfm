<cfoutput>

<h1>Create a New User</h1>

#startFormTag(action="create")#

    <div>#textField(objectName="user", property="name", label="Name")#</div>

    <div>#textField(objectName="user", property="email", label="Email")#</div>

    <div>#passwordField(objectName="user", property="password", label="Password")#</div>

    <div>#submitTag()#</div>

#endFormTag()#

</cfoutput>
