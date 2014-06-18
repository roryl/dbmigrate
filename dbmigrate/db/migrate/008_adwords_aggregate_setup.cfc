<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="adwords aggregate setup">
	<cffunction name="up">
		<cfscript>

			t = createTable(name='adwords_group_by',primaryKey="adwords_group_by_id");
			t.column(columnName="adwords_group_by_name",columnType="string",limit="32");
			t.column(columnName="adwords_group_by_min_duration",columnType="integer",limit="11");
			t.column(columnName="adwords_group_by_max_deviation",columnType="decimal",precision="4",scale="2");			
			t.create();

			t = createTable(name='adwords_aggregate_alltime',primaryKey="adwords_aggregate_alltime_id");
			t.column(columnName="adwords_aggregate_alltime_campaign_id",columnType="integer",limit="11");
			t.column(columnName="adwords_aggregate_alltime_group_by_id",columnType="integer",limit="11");			
			t.column(columnName="adwords_aggregate_alltime_clicks",columnType="integer",limit="11");
			t.column(columnName="adwords_aggregate_alltime_impressions",columnType="integer",limit="11");
			t.column(columnName="adwords_aggregate_alltime_conversions",columnType="integer",limit="11");
			t.column(columnName="adwords_aggregate_alltime_cost",columnType="decimal",precision="4",scale="2");
			t.column(columnName="adwords_aggregate_alltime_revenue",columnType="decimal",precision="4",scale="2");			
			t.column(columnName="adwords_aggregate_alltime_roi",columnType="decimal",precision="4",scale="2");
			t.column(columnName="adwords_aggregate_alltime_ctr",columnType="decimal",precision="4",scale="2");
			t.column(columnName="adwords_aggregate_alltime_cr",columnType="decimal",precision="4",scale="2");
			t.column(columnName="adwords_aggregate_alltime_avg_cpc",columnType="decimal",precision="4",scale="2");
			t.column(columnName="adwords_aggregate_alltime_position",columnType="decimal",precision="4",scale="2");
			t.column(columnName="adwords_aggregate_alltime_impression_revenue",columnType="decimal",precision="6",scale="4");
			t.column(columnName="adwords_aggregate_alltime_date",columnType="date");
			t.create();			

			t = createTable(name='adwords_group_by_results',primaryKey="adwords_group_by_results_id");
			t.column(columnName="adwords_group_by_results_group_by_id",columnType="integer",limit="11");
			t.column(columnName="adwords_group_by_results_average_deviation",columnType="decimal",precision="4",scale="2");
			t.column(columnName="adwords_group_by_results_success",columnType="boolean",default="0");
			t.column(columnName="adwords_group_by_results_date",columnType="date");					
			t.create();

			//Setup default values for the table
			

			addColumn(table="campaigns",columnName="campaigns_google_campaign_id",columnType="integer",limit="11");

		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
			dropTable('adwords_aggregate_alltime');
			dropTable('adwords_group_by');
			dropTable('adwords_group_by_results');

			removeColumn(table="campaigns",columnName="campaigns_google_campaign_id");
		</cfscript>
	</cffunction>
</cfcomponent>
