component{

	/* Use java system to get settings from env */
	javaSystem = createObject( 'java', 'java.lang.System' );

	/* Load .env file properties into Java system properties variables */
	private void function loadEnvProperties() {
		/* Load .env file into Environment variables */
		var basePath = getDirectoryFromPath(getCurrentTemplatePath());
		var rootPath = REReplaceNoCase( basePath, "config(\\|/)", "" );
		if ( fileExists("#rootPath#/.env") ) {

			//load the environment properties file
			var fis = createObject( 'java', 'java.io.FileInputStream' ).init( "#rootPath#/.env" );
			var propertyFile = createObject( 'java', 'java.util.Properties' ).init();
			propertyFile.load( fis );
			fis.close();

			/* Append/overrite current settings */
			for ( var key in propertyFile ) {
				javaSystem.setProperty( key, propertyFile[ key ] );
			}

		}
	}

	// Configure ColdBox Application
	function configure(){


		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "Recipe Box",
			eventName 				= "event",

			//Development Settings
			reinitPassword			= "",
			handlersIndexAutoReload = false,

			//Implicit Events
			defaultEvent			= "",
			requestStartHandler		= "Main.onRequestStart",
			requestEndHandler		= "",
			applicationStartHandler = "Main.onAppInit",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			applicationHelper 			= "",
			viewsHelper					= "",
			modulesExternalLocation		= [],
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			controllerDecorator			= "",

			//Error/Exception Handling
			exceptionHandler		= "",
			onInvalidEvent			= "",
			customErrorTemplate		= "",

			//Application Aspects
			handlerCaching 			= true,
			eventCaching			= true,
			proxyReturnCollection 	= false
		};

		loadEnvProperties();

		// custom settings
		settings = {
			PASSWORD_BLACKLIST_FILE = javaSystem.getProperty("PASSWORD_BLACKLIST_FILE", "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10k-most-common.txt"),
			RECAPTCHA_ENABLED = javaSystem.getProperty("RECAPTCHA_ENABLED", false),
			RECAPTCHA_SITE_KEY = javaSystem.getProperty("RECAPTCHA_SITE_KEY", ""),
			RECAPTCHA_SECRET_KEY = javaSystem.getProperty("RECAPTCHA_SECRET_KEY", "")
		};

		//Datasources
		datasources = {
			recipebox   = {name="RecipeBox", dbType="mssql"}
		};

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "127\.0\.0\.1"
		};

		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = false,
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};


		//Layout Settings
		layoutSettings = {
			defaultLayout = "",
			defaultView   = ""
		};

		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = false,
			customInterceptionPoints = ""
		};

		//Register interceptors as an array, we need order
		interceptors = [
			//SES
			{class="coldbox.system.interceptors.SES",
			 properties={}
			}
		];

		// Debugger Settings
		debugger = {
		    // Activate debugger for everybody
		    debugMode = false,
		    // Setup a password for the panel
		    debugPassword = "",
		    enableDumpVar = true,
		    persistentRequestProfiler = true,
		    maxPersistentRequestProfilers = 10,
		    maxRCPanelQueryRows = 50,
		    showTracerPanel = true,
		    expandedTracerPanel = true,
		    showInfoPanel = true,
		    expandedInfoPanel = true,
		    showCachePanel = true,
		    expandedCachePanel = false,
		    showRCPanel = true,
		    expandedRCPanel = false,
		    showModulesPanel = true,
		    expandedModulesPanel = false,
		    showRCSnapshots = false,
		    wireboxCreationProfiler=false
		};


	}

	/**
	* Development environment
	*/
	function development(){
		coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";
		coldbox.reinitPassword = "";
		coldbox.handlerCaching = false;
		coldbox.handlersIndexAutoReload = true;
		coldbox.eventCaching = false;

	}

}