<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="testKeyExistsInStructureDebug1">
	        <cfset loc.a = {a=1, b=2, c=3}>
	        <cfset loc.b = "b">
	        <cfset debug("loc.a")>
	        <cfset assert("StructKeyExists(loc.a, loc.b)")>
	</cffunction>

	<cffunction name="testKeyExistsInStructureDebug2">
	        <cfset loc.a = {a=1, b=2, c=3}>
	        <cfset loc.b = "b">
	        <cfset debug("loc.a", false)>
	        <cfset assert("StructKeyExists(loc.a, loc.b)")>
	</cffunction>

	<cffunction name="testKeyExistsInStructureDebug3">
	        <cfset loc.a = {a=1, b=2, c=3}>
	        <cfset loc.b = "b">
	        <cfset debug(expression="loc.a", format="text")>
	        <cfset assert("StructKeyExists(loc.a, loc.b)")>
	</cffunction>

</cfcomponent>