<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="new pages fields">
	<cffunction name="up">
		<cfscript>
		addColumn(table="pages",columnName="pages_type",columnType="string",limit="256",default="article");
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		removeColumn(table="pages",columnName="pages_type");
		</cfscript>
	</cffunction>
</cfcomponent>
