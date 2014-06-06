<cfcomponent extends="wheelsMapping.Test">

        <cffunction name="test_errors_display_when_new_user_is_invalid">

                <!--- setup some default params for the tests --->
                <cfset loc.params = {controller="users", action="create"}>

                <!--- create an empty user param to pass to the controller action --->
                <cfset loc.params.user = StructNew()>

                <!--- create an instance of the controller --->
                <cfset loc.controller = controller("users", loc.params)>

                <!--- process the create action of the controller --->
                <cfset loc.controller.$processAction()>

                <!--- get copy of the code the view generated --->
                <cfset loc.response = loc.controller.response()>

                <!--- make sure the flashmessage was displayed  --->
                <cfset loc.message = '<div class="flashMessages">'>
                <cfset assert('loc.response contains loc.message')>

        </cffunction>

</cfcomponent>