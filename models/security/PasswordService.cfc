/* 
* Password service
*/
component singleton {

	property name="PASSWORD_BLACKLIST";
	property name="bcrypt" inject="BCrypt@BCrypt";
	property name="wirebox" inject="wirebox";
	property name="passwordEstimator" inject="security.PasswordStrengthEstimator";
	

	/**
	 * Constructor
	 * 
	 * @passwordBlacklistFile.inject coldbox:setting:PASSWORD_BLACKLIST_FILE
	 */ 
	public PasswordService function init( required string passwordBlacklistFile ) {

		PASSWORD_BLACKLIST = loadBlacklist( arguments.passwordBlacklistFile );

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
	* Check if a password is blacklisted
	*/
	public boolean function isBlacklisted( required string password ) {

		return PASSWORD_BLACKLIST.find( lcase( arguments.password ) );
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

		/* Not on the blacklist */
		if ( isBlacklisted( arguments.password ) ) {
			validationResult.addError("Your password is not allowed because it is too common!");
		}

		return validationResult;
	}

	/**
	* Load a blacklist
	*/
	private array function loadBlacklist( required string passwordBlacklistFile ) {
		var blacklist = [];

		if ( arguments.passwordBlacklistFile.len() == 0 ) {
			blacklist = loadBlacklistFromURL( "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10k-most-common.txt" );
		}
		else if ( isValid( "URL", arguments.passwordBlacklistFile ) ) {
			blacklist = loadBlacklistFromURL( arguments.passwordBlacklistFile );
		}
		else if ( fileExists( arguments.passwordBlacklistFile ) ){
			blacklist = loadBlacklistFromFile( arguments.passwordBlacklistFile );
		}
		
		return blacklist;
	}

	/**
	* Load a blacklist from file
	*/
	private array function loadBlacklistFromFile( required string file ) {
		var blacklist = [];

		try {
			blacklist = listToArray( 
				fileRead( arguments.file ), 
				chr(10) & chr(13) 
			);
		}
		catch(any e) { }
		
		return blacklist;
	}

	/**
	* Load a blacklist from url
	*/
	private array function loadBlacklistFromURL( required string url ) {
		var blacklist = [];
		var httpResult = "";

		try {
			cfhttp( url = arguments.url, result = "httpResult"  );
			blacklist = listToArray( 
				httpResult.fileContent, 
				chr(10) & chr(13) 
			);
		}
		catch(any e) {}
		
		return blacklist;
		
	}

}