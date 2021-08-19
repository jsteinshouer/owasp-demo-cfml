/* 
* Password service
*/
component singleton {

	property name="BLOCKED_PASSWORDS";
	property name="bcrypt" inject="BCrypt@BCrypt";
	property name="wirebox" inject="wirebox";
	property name="passwordEstimator" inject="security.PasswordStrengthEstimator";
	

	/**
	 * Constructor
	 * 
	 * @blockedPasswordsFile.inject coldbox:setting:BLOCKED_PASSWORDS_FILE
	 */ 
	public PasswordService function init( required string blockedPasswordsFile ) {

		BLOCKED_PASSWORDS = loadBlocklist( arguments.blockedPasswordsFile );

		return this;
	}

	/**
	* Hash a password using bcrypt
	*/
	public string function hashPassword( required string password ) {

		return bcrypt.hashPassword( arguments.password );
	}

	/**
	* Check the hashed password using bcrypt.
	*/
	public string function checkPassword( required string password, required string hash ) {

		return bcrypt.checkPassword( arguments.password, arguments.hash );
	}


	/**
	* Check if a password is blocklisted
	*/
	public boolean function isBlocked( required string password ) {

		return BLOCKED_PASSWORDS.find( lcase( arguments.password ) );
	}

	/**
	* Check if a password is valid
	*/
	public models.util.ValidationResult function validatePassword( required string password ) {

		var validationResult = wirebox.getInstance("util.ValidationResult");

		/* Must be at least 8 characters long */
		if ( arguments.password.len() < 8 ) {
			validationResult.addError("The password must be at least 8 characters.");
		}

		/* Make sure estimator score is not too weak */
		var estimate = passwordEstimator.estimate( arguments.password );
		if ( estimate.getScore() < 2 ) {
			// writeDump(estimate);abort;
			var message = "The password is too weak.";
			if ( estimate.getWarning().len() ) {
				message &= " " & estimate.getWarning();
			}

			message &= " " & estimate.getSuggestions().toList(", ");
			validationResult.addError(message);
		}

		/* Not on the blocklist */
		if ( isBlocked( arguments.password ) ) {
			validationResult.addError("Your password is not allowed because it is too common!");
		}

		return validationResult;
	}

	/**
	* Load a blocklist
	*/
	private array function loadBlocklist( required string blockedPasswordsFile ) {
		var blocklist = [];

		if ( arguments.blockedPasswordsFile.len() == 0 ) {
			blocklist = loadBlocklistFromURL( "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10k-most-common.txt" );
		}
		else if ( isValid( "URL", arguments.blockedPasswordsFile ) ) {
			blocklist = loadBlocklistFromURL( arguments.blockedPasswordsFile );
		}
		else if ( fileExists( arguments.blockedPasswordsFile ) ){
			blocklist = loadBlocklistFromFile( arguments.blockedPasswordsFile );
		}
		
		return blocklist;
	}

	/**
	* Load a blocklist from file
	*/
	private array function loadBlocklistFromFile( required string file ) {
		var blocklist = [];

		try {
			blocklist = listToArray( 
				fileRead( arguments.file ), 
				chr(10) & chr(13) 
			);
		}
		catch(any e) { }
		
		return blocklist;
	}

	/**
	* Load a blocklist from url
	*/
	private array function loadBlocklistFromURL( required string url ) {
		var blocklist = [];
		var httpResult = "";

		try {
			cfhttp( url = arguments.url, result = "httpResult"  );
			blocklist = listToArray( 
				httpResult.fileContent, 
				chr(10) & chr(13) 
			);
		}
		catch(any e) {}
		
		return blocklist;
		
	}

}