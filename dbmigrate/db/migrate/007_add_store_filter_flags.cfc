<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="add store filter flags">
	<cffunction name="up">
		<cfscript>
			addColumn(table="stores",columnName="stores_show_popularity_sort",columnType="integer",default="1");
			addColumn(table="stores",columnName="stores_show_latest_sort",columnType="integer",default="1");
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
			removeColumn(table="stores",columnName="stores_show_popularity_sort");
			removeColumn(table="stores",columnName="stores_show_latest_sort");
		</cfscript>
	</cffunction>
</cfcomponent>
