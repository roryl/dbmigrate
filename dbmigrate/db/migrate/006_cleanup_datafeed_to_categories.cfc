<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="cleanup datafeed_to_categories">
	<cffunction name="up">
		<cfscript>
		removeColumn(table="datafeed_to_categories",columnName="products_description_boolean");
		removeColumn(table="datafeed_to_categories",columnName="products_description_match");
		removeColumn(table="datafeed_to_categories",columnName="products_name_boolean");
		removeColumn(table="datafeed_to_categories",columnName="products_name_match");
		removeColumn(table="datafeed_to_categories",columnName="products_category_final_boolean");
		removeColumn(table="datafeed_to_categories",columnName="products_category_final_match");
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		addColumn(table="datafeed_to_categories",columnName="products_description_boolean",columnType="string",limit="8");
		addColumn(table="datafeed_to_categories",columnName="products_description_match",columnType="string",limit="256");
		addColumn(table="datafeed_to_categories",columnName="products_name_boolean",columnType="string",limit="8");
		addColumn(table="datafeed_to_categories",columnName="products_name_match",columnType="string",limit="256");
		addColumn(table="datafeed_to_categories",columnName="products_category_final_boolean",columnType="string",limit="8");
		addColumn(table="datafeed_to_categories",columnName="products_category_final_match",columnType="string",limit="256");
		</cfscript>
	</cffunction>
</cfcomponent>
