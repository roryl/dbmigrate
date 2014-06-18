/**
*
* @author  Rory Laitila
* @description Wrapper around the CFadmin tag to allow us to automate admin setup tasks
* 
* Railo Documentation:
* http://www.getrailo.org/index.cfm/documentation/cfadmin-doc/
* 
* In order to figure out how to use the cfadmin tag, you need to introspect the use of the tag in the cfadmin
* from the source code: https://github.com/getrailo/railo/tree/e196a219779edf1846cc5915afffab538bb23d90/railo-cfml/railo-admin/admin
*
*/

component output="false" displayname="" accessors="true" {

	property name="password";
	property name="adminType" hint="The admin interface that we are accessing, either will be web or server";

	property name="isCacheListDirty" hint="Boolean as to whether the cache list is dirty. If it is not, then do not get the cache list against which is expensive";

	public function init(required string password, required string adminType){
		setPassword(arguments.password);
		setAdminType(arguments.adminType);
		setIsCacheListDirty(true);
		return this;
	}

	/** CACHE FUNCTIONS *************/
	public function createRAMCache(required string name,
								   timeToIdleSeconds=0,
							       timeToLiveSeconds=0, 
							       useAsSessionClientStorage=false,
							       defaultStorageType="")
	{
		admin action="updateCacheConnection"
			  type="#variables.adminType#"
			  password="#variables.password#"
			  class="railo.runtime.cache.ram.RamCache"
			  custom="#{timeToIdleSeconds:arguments.timeToIdleSeconds,timeToLiveSeconds:arguments.timeToLiveSeconds}#"
			  name="#arguments.name#" 
			  storage="#arguments.useAsSessionClientStorage#"
			  default="#arguments.defaultStorageType#";
		setIsCacheListDirty(true);
		return true;
	}

	public function deleteCache(required string name)
	{
		admin action="removeCacheConnection" password="#variables.password#" adminType="#variables.adminType#" name="#arguments.name#";
		setIsCacheListDirty(true);
		return true;
	}

	public function getCaches(forceGet=false)
	{
		if(getIsCacheListDirty() or arguments.forceGet)
		{
			admin action="getCacheConnections" type="#variables.adminType#" password="#variables.password#" returnVariable="connections";
			variables.cacheList = connections;
			setIsCacheListDirty(false);
		}
	
		return variables.cacheList;
	}

	public function cacheExists(required string name)
	{
		local.caches = getCaches();
		query name="local.cache" dbtype="query"{
			echo("SELECT * FROM
				  local.caches
				  WHERE name = '#arguments.name#'");
		}
		if(local.cache.recordCount IS 1)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	/*********************************/

	/** MAPPING FUNCTIONS *************/

	public function mappingExists(required string virtualPath)
	{
		local.mappings = getmappings();
		query name="local.cache" dbtype="query"{
			echo("SELECT * FROM
				  local.mappings
				  WHERE virtual = '#arguments.virtualPath#'");
		}
		if(local.cache.recordCount IS 1)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	public query function getMappings()
	{
		admin 
			action="getMappings"
			type="#variables.adminType#"
			password="#variables.password#"
			returnVariable="local.mappings";
			
		return local.mappings;
	}

	public function createMapping(virtualPath="",physicalPath="",archivePath="",primary="physical",trusted="false",toplevel=true)
	{		

		admin 
			action="updateMapping"
			type="#variables.adminType#"
			password="#variables.password#"
			virtual="#arguments.virtualPath#"
			physical="#arguments.physicalPath#"
			archive="#arguments.archivePath#"
			primary="#arguments.primary#"
			trusted="#arguments.trusted#"
			toplevel="#arguments.toplevel#";
			return this;
		
	}

	public function deleteMapping(required string virtualPath)
	{
		admin 
			action="removeMapping"
			type="#variables.adminType#"
			password="#variables.password#"
			virtual="#arguments.virtualPath#"
			returnVariable="local.mappings";
			return this;
	}

	/*****************************
	**  DATASOURCE FUNCTIONS
	******************************/

	public query function getDatasources()
	{
		admin 
			action="getDatasources"
			type="#variables.adminType#"
			password="#variables.password#"
			returnVariable="local.datasources";
		return local.datasources;
	}

	public function createDatasource(){

			
			/*admin action="updateDatasource" 
			type="#variables.adminType#" 
			password="#variables.password#"

			classname="#driver.getClass()#"
			dsn="#driver.getDSN()#"

			name="#form.name#"
			newName="#form.newName#"

			host="#form.host#"
			database="#form.database#"
			port="#form.port#"
			timezone="#form.timezone#"
			dbusername="#form.username#"
			dbpassword="#form.password#"

			connectionLimit="#form.connectionLimit#"
			connectionTimeout="#form.connectionTimeout#"
			metaCacheTimeout="#form.metaCacheTimeout#"
			blob="#getForm('blob',false)#"
			clob="#getForm('clob',false)#"
			validate="#getForm('validate',false)#"
			storage="#getForm('storage',false)#"

			allowed_select="#getForm('allowed_select',false)#"
			allowed_insert="#getForm('allowed_insert',false)#"
			allowed_update="#getForm('allowed_update',false)#"
			allowed_delete="#getForm('allowed_delete',false)#"
			allowed_alter="#getForm('allowed_alter',false)#"
			allowed_drop="#getForm('allowed_drop',false)#"
			allowed_revoke="#getForm('allowed_revoke',false)#"
			allowed_create="#getForm('allowed_create',false)#"
			allowed_grant="#getForm('allowed_grant',false)#"
			verify="#verify#"
			custom="#custom#"
			dbdriver="#dbdriver#"
			remoteClients="#request.getRemoteClients()#";*/
			return this;
	}

}