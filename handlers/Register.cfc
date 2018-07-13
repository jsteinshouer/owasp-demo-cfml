/**
* My Event Handler Hint
*/
component extends="coldbox.system.EventHandler"{

	property name="userService" inject="users.UserService";
	property name="securityService" inject="security.SecurityService";
	property name="passwordService" inject="security.PasswordService";
	
	/**
	* Executes before all handler actions
	*/
	any function preHandler( event, rc, prc, action, eventArguments ){

	}

	public void function index(event,rc,prc) {
		event.paramValue("message","");
		event.paramValue("firstName","");
		event.paramValue("lastName","");
		event.paramValue("username","");
		
		event.setView(view="security/register");
	}

	public void function submit(event,rc,prc) {
		event.paramValue("message","");

		if (structkeyexists(rc,'username') and structkeyexists(rc,'password')) {

			if (!len(rc.username) || !len(rc.password)) {
				rc.message = "Please enter a username and password!";
			}
			else {
				var passwordValidationResult = passwordService.validatePassword( rc.password );
				rc.message = passwordValidationResult.hasErrors() ? passwordValidationResult.getErrors()[1] : "";
			}

			if ( !len(rc.message) ) {
				var user = userService.get();
				
				user.setFirstName(rc.firstName);
				user.setLastName(rc.lastName);
				user.setUsername(rc.username);
				var hash = passwordService.hashPassword(rc.password);
				user.setPassword(hash);

				userService.save(user);
				
				/*** Redirect user ***/
				setNextEvent("login");
			}
		}

		event.setView(view="security/register");

	}

	
	
}