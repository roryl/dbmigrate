<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="new stores templates fields">
	<cffunction name="up">
		<cfscript>
		execute("ALTER TABLE stores_templates ADD color_leftFilterH3BottomBorder VARCHAR(32) NOT NULL DEFAULT '##000000' AFTER color_leftFilterH3Text;");
		execute("ALTER TABLE stores_templates ADD color_productListBorderHover VARCHAR(32) NOT NULL DEFAULT '##cccccc' AFTER color_paginationHoverBorder;");
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		removeColumn(table="stores_templates",columnName="color_leftFilterH3BottomBorder");
		removeColumn(table="stores_templates",columnName="color_productListBorderHover");
		</cfscript>
	</cffunction>
</cfcomponent>
