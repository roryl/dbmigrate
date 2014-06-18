<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="meta data tables">
	<cffunction name="up">
		<cfscript>
		t = createTable(name='products_meta_data',primaryKey="products_meta_data_id");		
		t.column(columnName="products_meta_data_products_composite_id",columnType="string",default="",limit="64");
		t.column(columnName="products_meta_data_field_name",columnType="string",default="",limit="255");
		t.column(columnName="products_meta_data_value",columnType="text",default="");		
		t.create();

		addIndex(table="products_meta_data",columnNames="products_meta_data_products_composite_id,products_meta_data_field_name",unique=true,indexName="idx_products_meta_data");

		execute('CREATE TABLE datafeed_universal_meta_data LIKE products_meta_data');

		addColumn(table="merchants",columnType="integer",columnName="merchants_datafeed_save_meta_data",default="0");
		
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		dropTable('products_meta_data');
		dropTable('datafeed_universal_meta_data');

		removeColumn(table="merchants",columnName="merchants_datafeed_save_meta_data");		
		</cfscript>
	</cffunction>
</cfcomponent>
