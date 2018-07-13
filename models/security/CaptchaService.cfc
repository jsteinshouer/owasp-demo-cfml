/**
* Used to validate reCaptcha responses from Google reCaptcha
*/
component singleton {

	property name="RECAPTCHA_SECRET_KEY" inject="Coldbox:setting:RECAPTCHA_SECRET_KEY";

	/**
	* Verify the reCaptcha response is valid
	* 
	* May need to check x-forwarded-for header in case LB or proxy to get IP
	*/
	function verify(
		string captchaResponse = "",
		string remoteIPAddress = cgi.REMOTE_ADDR
	) {
		var isValid = false;

		if ( len( arguments.captchaResponse ) ) {
			var cfhttp = {};
			cfhttp(url="https://www.google.com/recaptcha/api/siteverify",method="post") {
				cfhttpparam(type="formfield",name="response",value="#arguments.captchaResponse#");
				cfhttpparam(type="formfield",name="remoteip",value="#arguments.remoteIPAddress#");
				cfhttpparam(type="formfield",name="secret",value="#RECAPTCHA_SECRET_KEY#");
			};

			if ( isJSON(cfhttp.fileContent) ) {
				var response = deserializeJSON( cfhttp.fileContent );
				isValid = response["success"] ?: false;
			}
		}

		return isValid;
	}
}