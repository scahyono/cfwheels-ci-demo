<cfoutput>
<h1>Create a New user</h1>

#flashMessages()#

#errorMessagesFor("user")#

#startFormTag(action="create")#


        #textField(objectName='user', property='username', label='Username')#

        #passwordField(objectName='user', property='password', label='Password')#
        #passwordField(objectName='user', property='passwordConfirmation', label='Confirm Password')#

        #textField(objectName='user', property='firstname', label='Firstname')#

        #textField(objectName='user', property='lastname', label='Lastname')#

        #submitTag()#

#endFormTag()#

#linkTo(text="Return to the listing", action="index")#
</cfoutput>