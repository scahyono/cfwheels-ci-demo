<cfquery datasource="webapp">
	create table users (id int not null identity, name varchar(100), email varchar(255), password varchar(15), PRIMARY KEY(id))
</cfquery>
Table users is created