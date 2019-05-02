/**
* 
* Service to handle application security
* 
* <h3>Usage</h3>
* <p>Inject using wirebox</p>
* <pre>
* property name="securityService" inject="security.SecurityService";
* </pre>
*
*
*/
component output="false" singleton="true"  {

	property name="userService" inject="users.UserService" hint="Rerference to the user service";
	property name="sessionStorage" inject="sessionStorage@cbstorages" hint="Coldbox session storage module";
	property name="oneTimePasswordService" inject="security.OneTimePasswordService";
	property name="passwordService" inject="security.PasswordService";
	// property name="logger" inject="logbox:logger:{this}" hint="Logbox logger reference for logging security events";


	/**
	* Authenticates a users credentials with data stored in the database. Returns boolean indicating if it was a valid username and password combination.
	*
	* @username.hint User's login id
	* @password.hint User' password
	*/
	public boolean function checkUsernameAndPassword(username,password) {

		var isValid = false;

		var q = queryExecute(
			"
				SELECT p_user, password
				FROM [user]
				WHERE
					username = :username
	
			",
			{
				username = arguments.username
			}
		);

		if (
			q.recordCount
			&& passwordService.checkPassword(arguments.password,q.password)
		) {			
				
			sessionStorage.setVar( "step1Valid",true );
			var user = userService.get( q.p_user );
			sessionStorage.setVar( "user", user );

			if ( user.isTwoFactorAuthenticationEnabled() ) {
				sessionStorage.setVar( "step2Required",true );
			}
			else {
				sessionStorage.setVar( "isLoggedIn",true );
				/* Rotate the session to avoid session fixation attacks*/
				sessionRotate();
			}


			isValid = true;
		}
		else {
			/* 
			* Hash the password even if account does 
			* not exist to attempt to prevent an attacker guessing  
			* account usernames based on timing
			*/
			passwordService.hashPassword(arguments.password);
		}			
		
		return isValid;
	}

	/**
	* Checks the session to see if the user is logged in
	*
	*/
	public any function isLoggedIn() {
		return sessionStorage.getVar("isLoggedIn",false);
	}

	/**
	* Checks the session to see if the user if step 1 was successful
	*
	*/
	public any function isStep1Valid() {
		return sessionStorage.getVar("step1Valid",false);
	}

	/**
	* Checks the session to see if the user is using 2-step authentication
	*
	*/
	public any function isStep2Required() {
		return sessionStorage.getVar("step2Required",false);
	}

	/**
	* Gets the currently logged in user from the session
	*
	*/
	public any function getLoggedInUser() {
		return sessionStorage.getVar("user",userService.get());
	}
	
	/**
	* logs the user out
	*
	*/
	public void function logout() {
		//logger.info("User logout for #getLoggedInUser().getUsername()#");
		sessionStorage.clearAll();
		sessionInvalidate();
	}

	/**
	* Verify the Step 2: One-Time Password
	*
	*/
	public boolean function verifyOneTimePassword( required string password ) {

		var user = getLoggedInUser();
		
		var isValid = oneTimePasswordService.verify( 
			key = user.getTwoFactorAuthenticationKey(), 
			userToken = arguments.password 
	    );
		
		if ( isValid ) {
			sessionStorage.setVar("isLoggedIn",true);
			/* Rotate the session to avoid session fixation attacks*/
			sessionRotate();
		}

		return isValid;
	}
	
	
}


