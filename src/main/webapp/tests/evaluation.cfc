<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="testAEqualsB">
	        <cfset loc.a = 1>
	        <cfset loc.b = 1>
	        <cfset assert("loc.a eq loc.b")>
	</cffunction>

	<cffunction name="testAIsLessThanB">
	        <cfset loc.a = 1>
	        <cfset loc.b = 5>
	        <cfset assert("loc.a lt loc.b")>
	</cffunction>

	<cffunction name="testKeyExistsInStructure">
	        <cfset loc.a = {a=1, b=2, c=3}>
	        <cfset loc.b = "b">
	        <!---
	        <cfset loc.b = "d">
	        --->
	        <cfset assert("StructKeyExists(loc.a, loc.b)")>
	</cffunction>

	<cffunction name="testTableNotFound">
	        <cfset loc.e = raised("model('thisHasNoTable')")>
	        <cfset loc.r = "Wheels.TableNotFound">
	        <cfset assert("loc.e eq loc.r")>
	</cffunction>

</cfcomponent>