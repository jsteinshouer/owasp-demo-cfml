/**
*
* Database Migration using Flyway
*
*/
component output="false" singleton="true" {
	
	/**
	*
	* Constructor
	* 
	* @dsn.inject coldbox:datasource:recipebox
	*
	*/
	public any function init( required dsn ) {

		var serviceFactory = createObject("java", "coldfusion.server.ServiceFactory");
		var datasourceService = serviceFactory.getDataSourceService();
		var ds = datasourceService.getDatasource( arguments.dsn.name );
		var directory = getDirectoryFromPath( expandPath("/") );
		flyway = createObject("java","org.flywaydb.core.Flyway");

		flyway.setDataSource(ds);
		// flyway.setOutOfOrder(true);
		// flyway.setSchemas(["PUBLIC"]);
		// flyway.setBaseLineOnMigrate(true);
		flyway.setLocations( ["filesystem:#directory#\db\migrations"] );
		
		return this;
	}

	/**
	*
	* Migrate the database
	*
	*/
	public void function migrate() {

		var out = flyway.migrate();
	}
	
	
}