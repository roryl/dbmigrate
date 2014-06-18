<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="store default category flag">
	<cffunction name="up">
		<cfscript>
		addColumn(table="stores_categories",columnName="sort_default",columnType="boolean",default="0");
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		removeColumn(table="stores_categories",columnName="sort_default");
		</cfscript>
	</cffunction>
</cfcomponent>
