<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="stores custom sorts field">
	<cffunction name="up">
		<cfscript>
		addColumn(table="stores",columnName="stores_custom_sort_fields",columnType="string",limit="1024",default="");
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		removeColumn(table="stores",columnName="stores_custom_sort_fields");
		</cfscript>
	</cffunction>
</cfcomponent>
