<cfoutput>

<h1>Edit User #user.name#</h1>

#flash("success")#

#startFormTag(action="update")#

    <div>#hiddenField(objectName="user", property="id")#</div>

    <div>#textField(objectName="user", property="name", label="Name")#</div>

    <div>#textField(objectName="user", property="email", label="Email")#</div>

    <div>
        #passwordField(objectName="user", property="password", label="Password")#
    </div>

    <div>#submitTag()#</div>

#endFormTag()#

</cfoutput>
