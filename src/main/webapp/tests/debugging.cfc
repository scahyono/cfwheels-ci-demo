<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="testKeyExistsInStructure">
	        <cfset loc.a = {a=1, b=2, c=3}>
	        <cfset loc.b = "d">
	        <cfset debug("loc.a")>
	        <cfset assert("StructKeyExists(loc.a, loc.b)")>
	</cffunction>

	<cffunction name="testKeyExistsInStructure">
	        <cfset loc.a = {a=1, b=2, c=3}>
	        <cfset loc.b = "d">
	        <cfset debug("loc.a", false)>
	        <cfset assert("StructKeyExists(loc.a, loc.b)")>
	</cffunction>

	<cffunction name="testKeyExistsInStructure">
	        <cfset loc.a = {a=1, b=2, c=3}>
	        <cfset loc.b = "d">
	        <cfset debug(expression="loc.a", format="text")>
	        <cfset assert("StructKeyExists(loc.a, loc.b)")>
	</cffunction>

</cfcomponent>