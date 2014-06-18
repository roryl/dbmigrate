<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="snippets_tables">
	<cffunction name="up">
		<cfscript>
			t = createTable(name='snippets',primaryKey="snippets_id");
			t.column(columnName="snippets_name",columnType="string",limit="64");
			t.column(columnName="snippets_content",columnType="binary");
			t.column(columnName="snippets_stores_id",columnType="integer",limit="11");
			t.create();
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
			dropTable('snippets');
		</cfscript>
	</cffunction>
</cfcomponent>
