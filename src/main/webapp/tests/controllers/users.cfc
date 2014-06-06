<cfcomponent extends="wheelsMapping.Test">

        <cffunction name="test_redirects_to_index_after_a_user_is_created">

                <!--- default params that are required by the controller --->
                <cfset loc.params = {controller="users", action="create"}>

                <!--- set the user params for creating a user --->
                <cfset loc.params.user = {
                        username = "myusername"
                        ,firstname = "Bob"
                        ,lastname = "Parkins"
                        ,password = "something"
                        ,passwordConfirmation = "something"
                }>

                <!--- create an instance of the controller --->
                <cfset loc.controller = controller(name="users", params=loc.params)>

                <!--- process the create action of the controller --->
                <cfset loc.controller.$processAction()>

                <!--- get the information about the redirect that should have happened --->
                <cfset loc.redirect = loc.controller.$getRedirect()>

                <!--- make sure that the redirect happened --->
                <cfset assert('StructKeyExists(loc.redirect, "$args")')>
                <cfset assert('loc.redirect.$args.action eq "index"')>

        </cffunction>

</cfcomponent>