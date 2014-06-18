<cfoutput>
<cfparam name="form.datasource" default="">
<cfparam name="form.app" default="">

<form action="#CGI.script_name & '?' & CGI.query_string#" method="post">
<select name="app" id="app">
	<cfloop array="#request.migrationApps#" item="key">
		<option value="#key#" #((key IS form.app)?"selected":"")#>#key#</option>
	</cfloop>
</select>

<cfif trim(form.app) IS "">
	Please select an application to migrate before continuing
	<input type="submit" value="go">
<cfelse>
	<br />
	<cfset datasourcesWeb = new dbmigrate.app.services.railo.administrator(password="123456",adminType="web").getDatasources()>
	
	<select name="datasource" id="datasource">
		<cfloop query="#datasourcesWeb#">
			<option value="#name#" #((name IS form.datasource)?"selected":"")#>#name#</option>
		</cfloop>		
	</select>

	<cfif trim(form.datasource) IS "">
	Please select a datasource before continuing 
	<input type="submit" value="go">
	
	<cfelse>
		<br />
		<input type="submit" value="go">
		</form>
		<cfif isDefined("Form.version")>	
			<cfset DBMigrateFeedback=new dbmigrate.dbmigrate.DBMigrate(datasource="#form.datasource#").migrateTo(Form.version)>
			<!--- <cfset flashInsert(DBMigrateFeedback=new dbmigrate.dbmigrate.DBMigrate(datasource="#form.datasource#").migrateTo(Form.version))> --->
			<!--- <cfset redirectTo(back=true)> --->
		<cfelseif isDefined("Form.migrationName")>
			<cfparam name="Form.templateName" default="">
			<cfparam name="Form.migrationPrefix" default="">
			<cfset DBMigrateFeedback2=new dbmigrate.dbmigrate.DBMigrate(datasource="#form.datasource#").createMigration(Form.migrationName,Form.templateName,Form.migrationPrefix)>
			<!--- <cfset flashInsert(DBMigrateFeedback2=new dbmigrate.dbmigrate.DBMigrate(datasource="#form.datasource#").createMigration(Form.migrationName,Form.templateName,Form.migrationPrefix))> --->
			<!--- <cfset redirectTo(back=true)> --->
		</cfif>

		<!--- Get current database version --->
		<cfset currentVersion = new dbmigrate.dbmigrate.DBMigrate(datasource="#form.datasource#").getCurrentMigrationVersion()>
		
		<!--- Get current list of migrations --->
		<cfset migrations = new dbmigrate.dbmigrate.DBMigrate(datasource="#form.datasource#").getAvailableMigrations()>
		<cfif ArrayLen(migrations)>
			<cfset lastVersion = migrations[ArrayLen(migrations)].version>
		<cfelse>
			<cfset lastVersion = 0>
		</cfif>

		<cfoutput>

		<cfinclude template="/dbmigrate/DBMigrate/css.cfm">

		<h1>DBMigrate</h1>
		<h2>inspired by Active Record migrations</h2>
		<p>Database Migrations are an easy way to build and alter your database structure using cfscript.</p>

		<!--- <cfif flashKeyExists("DBMigrateFeedback")>
			<h2>Migration result</h2>
			<pre>#flash("DBMigrateFeedback")#</pre>
		</cfif> --->

		<cfif isDefined("DBMigrateFeedback")>
			<h2>Migration result</h2>
			<pre>#DBMigrateFeedback#</pre>
		</cfif>

		<h2>Datasource</h2>
		<p>Current datasource is <strong>#form.datasource#</strong></p>

		<h2>Current version</h2>
		<p>Current database version is <strong>#currentVersion#</strong></p>

		<cfif ArrayLen(migrations) gt 0>
			<h2>Migrate</h2>
			<form action="#CGI.script_name & '?' & CGI.query_string#" method="post">
			<input type="hidden" name="datasource" id="datasource" value="#form.datasource#" />
			<input type="hidden" name="app" id="app" value="#form.app#" />
			<p>Migrate to version
			<select name="version">
			<cfif lastVersion neq 0><option value="#lastVersion#" selected="selected">All non-migrated</option></cfif>
			<cfif currentVersion neq "0"><option value="0">0 - empty</option></cfif>
			<cfloop array="#migrations#" index="migration">
			<option value="#migration.version#">#migration.version# - #migration.name# <cfif migration.status eq "migrated">(migrated)<cfelse>(not migrated)</cfif></option>
			</cfloop>
			</select>
			<input type="submit" value="go">
			</p>
			</form>

			<!--- List migrations available --->
			<h2>Available migrations</h2>
			<p>
			<cfloop array="#migrations#" index="migration">
				<span<cfif migration.status eq "migrated"> style="font-weight:bold;"</cfif>>
					#migration.version# - #migration.name#
					<cfif migration.loadError neq ""> (load error: #migration.loadError#)</cfif>
					<cfif migration.details neq ""> (#migration.details#)</cfif>
					- <em><cfif migration.status eq "migrated">migrated<cfelse>not migrated</cfif></em>
				</span><br />
			</cfloop>
			</p>
		</cfif>

			<h2 style="padding-top:10px;">Create new migration file from template</h2>
			
			<!--- <cfif flashKeyExists("DBMigrateFeedback2")>
			<pre style="margin-top:10px;">#flash("DBMigrateFeedback2")#</pre>
			</cfif> --->
			
			<cfif isDefined("DBMigrateFeedback2")>
			<pre style="margin-top:10px;">#DBMigrateFeedback2#</pre>
			</cfif>

			<form action="#CGI.script_name & '?' & CGI.query_string#" method="post">
			<input type="hidden" name="datasource" id="datasource" value="#form.datasource#" />
			<input type="hidden" name="app" id="app" value="#form.app#" />
			<p style="padding-top:10px;">Select template:
			<select name="templateName">
			 <option value="blank">Blank migration</option>
			 <option value="create-table">Create table</option>
			 <option value="change-table">Change table</option>
			</select>
			</p>
			
			<cfif ArrayLen(migrations) eq 0>
			<p>Migration prefix:
			<select name="migrationPrefix">
			 <option value="timestamp">Timestamp (e.g. #dateformat(now(),'yyyymmdd')##timeformat(now(),'hhmmss')#)</option>
			 <option value="numeric">Numeric (e.g. 001)</option>
			</select>
			</p>
			</cfif>
			
			<p>Migration description: 
			<input name="migrationName" type="text" size="30">
			(eg. 'creates member table') </p>
			<p><input type="submit" value="create"></p>
			</form>

		</cfoutput>


	</cfif>

</cfif>


</cfoutput>


<cfset request.layout = false>