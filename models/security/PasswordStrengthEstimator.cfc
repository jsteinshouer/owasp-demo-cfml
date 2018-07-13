/**
* Used to estimate the strength of user's password for providing feedback
* 
* Uses the nbvcxz Java library
* 
* https://github.com/GoSimpleLLC/nbvcxz
* 
* Inspired by: https://github.com/dropbox/zxcvbn
* 
*/
component singleton="true" {

	property name="nbvcxz";

	/**
	* Constructor
	*/
	PasswordStrengthEstimator function init(){

		variables.nbvcxz = createObject( "java", "me.gosimple.nbvcxz.Nbvcxz" ).init();

		return this;
	}

	/**
	* Esitimate the strength of a password
	*/
	PasswordStrengthEstimatorResult function estimate( required string password ){

		var estimatorResult = new PasswordStrengthEstimatorResult();
		var nbvcxzResult = nbvcxz.estimate( arguments.password );

		estimatorResult.setEntropy( nbvcxzResult.getEntropy() );
		estimatorResult.setGuesses( nbvcxzResult.getGuesses() );
		estimatorResult.setFeedbackResult( nbvcxzResult.getFeedback().getResult() );
		estimatorResult.setSuggestions( nbvcxzResult.getFeedback().getSuggestion() );
		estimatorResult.setWarning( nbvcxzResult.getFeedback().getWarning() );

		return estimatorResult;
	}

}