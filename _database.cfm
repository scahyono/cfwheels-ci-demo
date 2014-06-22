<cfquery datasource="webapp" name="tableExists">
	select * from INFORMATION_SCHEMA.TABLES where table_name = 'USERS'
</cfquery>
<cfif tableExists.RecordCount gt 1>
	<cfquery datasource="webapp">
		drop table users
	</cfquery>
</cfif>
<cfquery datasource="webapp">
	create table users (id int not null identity, name varchar(100), firstname varchar(100), lastname varchar(100), email varchar(255), password varchar(32), PRIMARY KEY(id))
</cfquery>
Table users is created
