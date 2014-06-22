<cfcomponent extends="wheelsMapping.Test">

        <cffunction name="setup">
                <cfset loc.controller = controller(name="dummy")>
                <cfset loc.f = loc.controller.distanceOfTimeInWords>
                <cfset loc.args = {}>
                <cfset loc.args.fromTime = now()>
                <cfset loc.args.includeSeconds = true>
        </cffunction>

        <cffunction name="testWithSecondsBelow5Seconds">
                <cfset loc.c = 5 - 1>
                <cfset loc.args.toTime = DateAdd('s', loc.c, loc.args.fromTime)>
                <cfinvoke method="loc.f" argumentCollection="#loc.args#" returnVariable="loc.e">
                <cfset loc.r = "less than 5 seconds">
                <cfset assert("loc.e eq loc.r")>
        </cffunction>

        <cffunction name="testWithSecondsBelow10Seconds">
                <cfset loc.c = 10 - 1>
                <cfset loc.args.toTime = DateAdd('s', loc.c, loc.args.fromTime)>
                <cfinvoke method="loc.f" argumentCollection="#loc.args#" returnVariable="loc.e">
                <cfset loc.r = "less than 10 seconds">
                <cfset assert("loc.e eq loc.r")>
        </cffunction>

</cfcomponent>
