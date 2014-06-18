<cfcomponent extends="affiliates.core.libraries.dbmigrate.Migration" hint="new css template fields">
	<cffunction name="up">
		<cfscript>
		execute("ALTER TABLE stores_templates ADD pixel_topFilterLeftFontSize VARCHAR(32) NOT NULL DEFAULT '14px' AFTER color_topFilterLeftBackground;");
		execute("ALTER TABLE stores_templates ADD text_topFilterLeftFontFamily VARCHAR(32) NOT NULL DEFAULT 'Lekton' AFTER pixel_topFilterLeftFontSize;");
		
		execute("ALTER TABLE stores_templates ADD pixel_leftFilterH3FontSize VARCHAR(32) NOT NULL DEFAULT '14px' AFTER color_leftFilterH3BottomBorder;");
		execute("ALTER TABLE stores_templates ADD text_leftFilterH3FontFamily VARCHAR(32) NOT NULL DEFAULT 'Lekton' AFTER pixel_leftFilterH3FontSize;");

		</cfscript>
	</cffunction>
	<cffunction name="down">
		<cfscript>
		removeColumn(table="stores_templates",columnName="pixel_topFilterLeftFontSize");
		removeColumn(table="stores_templates",columnName="text_topFilterLeftFontFamily");
		removeColumn(table="stores_templates",columnName="pixel_leftFilterH3FontSize");
		removeColumn(table="stores_templates",columnName="text_leftFilterH3FontFamily");
		</cfscript>
	</cffunction>
</cfcomponent>
