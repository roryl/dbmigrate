<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="change stores template fields ">
	<cffunction name="up">
		<cfscript>
		execute("ALTER TABLE stores_templates ADD color_sortByBackgroundActive VARCHAR(32) NOT NULL DEFAULT '##EE3C1F' AFTER color_sortByBackground;");		
		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		removeColumn(table="stores_templates",columnName="color_sortByBackgroundActive");
		</cfscript>
	</cffunction>
</cfcomponent>
