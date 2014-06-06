<cfcomponent extends="Model" output="false">

        <cffunction name="init">

                <!--- validations on the properties of model --->
                <cfset validatesPresenceOf("username,firstname,lastname")>
                <cfset validatesPresenceOf(property="password", when="oncreate")>
                <cfset validatesConfirmationOf(property="password", when="oncreate")>

                <!--- we never want to retrieve the password --->
                <cfset afterFind("blankPassword")>

                <!--- this callback will secure the password when the model is saved --->
                <cfset beforeSave("securePassword")>

        </cffunction>

        <cffunction name="securePassword" access="private">

                <cfif not len(this.password)>
                        <!--- we remove the password if it is blank. the password could be blank --->
                        <cfset structdelete(this, "password")>
                <cfelse>
                        <!--- else we secure it --->
                        <cfset this.password = _securePassword(this.password)>
                </cfif>

        </cffunction>

        <cffunction name="_securePassword">
                <cfargument name="password" type="string" required="true">

                <cfreturn hash(arguments.password)>

        </cffunction>

        <cffunction name="blankPassword" access="private">

                <cfif StructKeyExists(arguments, "password")>
                        <cfset arguments.password = "">
                </cfif>
                <cfreturn arguments>

        </cffunction>

</cfcomponent>