component extends="coldbox.system.EventHandler" {

	property name="userService" inject="users.UserService";
	property name="securityService" inject="security.SecurityService";
	property name="dbMigrationService" inject="db.MigrationService";
	property name="errorLogger" inject="logbox:logger:errorLogger";

	// Default Action
	function index(event,rc,prc){
		prc.welcomeMessage = "Welcome to ColdBox!";
		event.setView("main/index");
	}

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit(event,rc,prc){

		/* Migrate db changes on app start */
		dbMigrationService.migrate();

	}

	function onRequestStart(event,rc,prc){

		// cfdump(var=event.getCurrentHandler());abort;

		if (
			securityService.isLoggedIn() == false 
			&& event.getCurrentEvent() != "security.login" 
			&& event.getCurrentHandler() != "register" 
			&& event.getCurrentEvent() != "security.authenticate"
			&& event.getCurrentEvent() != "security.step2"
			&& event.getCurrentEvent() != "security.verifyCode"
			&& event.getCurrentEvent() != "security.estimatePasswordStrength"
		) {
			setNextEvent(event="login");
		}

		prc.isLoggedIn = securityService.isLoggedIn();

	}

	function onRequestEnd(event,rc,prc){

	}

	function onSessionStart(event,rc,prc){

	}

	function onSessionEnd(event,rc,prc){
		var sessionScope = event.getValue("sessionReference");
		var applicationScope = event.getValue("applicationReference");
	}

	function onException(event,rc,prc){
		//Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		//Place exception handler below:
		errorLogger.error("An Error has occured: #exception.getMessage()#");

	}

	function onMissingTemplate(event,rc,prc){
		//Grab missingTemplate From request collection, placed by ColdBox
		var missingTemplate = event.getValue("missingTemplate");

	}

}