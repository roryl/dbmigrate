component accessors="true" {

    
    property formatterService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	public void function default( rc ) {
        
        param name="form.app" default="";

        if(form.app IS NOT "" AND arrayContainsNoCase(request.migrationApps,form.app))
        {
        	request.dbmigrationMapping = form.app;
        	request.dbMigrationPath = expandPath("/#form.app#");
        }

	}
	
}
