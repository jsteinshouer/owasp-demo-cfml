/**
* Password strength estimation result
*/
component accessors="true" extends="models.BaseEntity" {

	property name="entropy" type="numeric";
	property name="guesses" type="numeric";
	property name="feedbackResult" type="string";
	property name="suggestions" type="any";
	property name="warning" type="string";
	property name="score" type="numeric" default=0 setter=false;

	/**
	*
	* Set the estimated guesses count
	*
	* @guesses.hint Number of estimated guesses
	*
	*/
	public any function setGuesses( required numeric guesses ) {
		
		variables.guesses = arguments.guesses;

		setScore();
	}

	/**
	*
	* Set the score based on the number of estimated guesses
	* 
	* Borrowed from https://github.com/dropbox/zxcvbn
	*
	*/
	private any function setScore() {
		
		if ( guesses < 1000 ) {
			variables.score = 0;
		}
		else if ( guesses < 1000000 ) {
			variables.score = 1;
		}
		else if ( guesses < 100000000 ) {
			variables.score = 2;
		}
		else if ( guesses < 10000000000 ) {
			variables.score = 3;
		}
		else if ( guesses >= 10000000000 ) {
			variables.score = 4;
		}
	}
	
	


}