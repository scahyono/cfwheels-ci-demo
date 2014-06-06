<cfcomponent extends="wheelsMapping.Test">
        
        <cffunction name="setup">

			<cfif IsDefined("url.reload")>
				<cfinclude template="../../_database.cfm">
			</cfif>
                
                <!--- create an instance of our model --->
                <cfset loc.user = model("user").new()>
                
                <!--- a struct that we wil use to set values of the property of the model --->
                <cfset loc.properties = {
                        username = "myusername"
                        ,firstname = "Bob"
                        ,lastname = "Parkins"
                        ,password = "something"
                        ,passwordConfirmation = "something"
                }>
        </cffunction>

	<cffunction name="test_user_valid">
	        
	        <!--- set the properties of the model --->
	        <cfset loc.user.setProperties(loc.properties)>
	        
	        <!--- assert that because the properties are set correct and meet validation, the model is valid --->
	        <cfset assert("loc.user.valid() eq true")>
	        
	</cffunction>

	<cffunction name="test_user_not_valid">
	        
	        <!--- assert the model is invalid when no properties are set --->
	        <cfset assert("loc.user.valid() eq false")>
	        
	</cffunction>

	<cffunction name="test_user_not_valid_password_confirmation">
	        
	        <!--- change the passwordConfirmation property so it doesn't match the password property --->
	        <cfset loc.properties.passwordConfirmation = "something1">
	        
	        <!--- set the properties of the model --->
	        <cfset loc.user.setProperties(loc.properties)>
	        
	        <!--- assert that because the password and passwordConfirmation DO NOT match, the model is invalid --->
	        <cfset assert("loc.user.valid() eq false")>
	        
	</cffunction>
        
	<cffunction name="test_password_secure_before_save_testing_a_callback">
	        
	        <!--- set the properties of the model --->
	        <cfset loc.user.setProperties(loc.properties)>
	        
	        <!--- call the _securePassword directly so we can test the value after the record is saved --->
	        <cfset loc.hashed = loc.user._securePassword(loc.properties.password)>
	        
	        <!--- 
	                save the model, but use transactions so we don't actually write to the database.
	                this prevents us from having to have to reload a new copy of the database everytime the test run
	        --->
	        <cfset loc.user.save(transaction="rollback")>
	        
	        <!--- get the password property of the model --->
	        <cfset loc.password = loc.user.password>
	        
	        <!--- make sure that password was hashed --->
	        <cfset assert('loc.password eq loc.hashed')>
	        
	</cffunction>

</cfcomponent>