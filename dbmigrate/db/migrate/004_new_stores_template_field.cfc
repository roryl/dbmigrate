<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="new stores template field">
	<cffunction name="up">
		<cfscript>
		execute("ALTER TABLE stores_templates ADD color_linkHover VARCHAR(32) NOT NULL DEFAULT '##EE3C1F' AFTER color_searchInput;");
		execute("ALTER TABLE stores_templates ADD color_productRedirectButton VARCHAR(32) NOT NULL DEFAULT '##c5c5c5' AFTER color_searchInput;");
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		removeColumn(table="stores_templates",columnName="color_linkHover");
		removeColumn(table="stores_templates",columnName="color_productRedirectButton");
		</cfscript>
	</cffunction>
</cfcomponent>
