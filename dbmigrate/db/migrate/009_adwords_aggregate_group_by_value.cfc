<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="adwords aggregate group by value">
	<cffunction name="up">
		<cfscript>
		addColumn(table="adwords_aggregate_alltime",columnName="adwords_aggregate_alltime_group_by_value",columnType="string",limit="64");		
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		removeColumn(table="adwords_aggregate_alltime",columnName="adwords_aggregate_alltime_group_by_value");
		</cfscript>
	</cffunction>
</cfcomponent>
