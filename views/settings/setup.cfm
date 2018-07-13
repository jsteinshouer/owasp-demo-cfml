<cfoutput>
<div class="container" style="margin-top: 30px">
	<h2>Two-Factor Authentication Setup</h2>
	<p>Scan this code on your device with your authenticator application.</p>
	<img
	src="data:image/*;base64,#toBase64( prc.qrCodeImage )#"
	height="300"
	/> <br />
	<div class="col-sm-4">
	<form method="POST" action="#event.buildLink("settings.enableTwoFactorAuthentication")#">
		<input type="text" name="passcode" class="form-control input-lg" placeholder="Passcode" required>
		<span id="helpBlock" class="help-block">Enter the code from your authentication app here to complete 2-factor authentication setup.</span>
		<button class="btn btn-lg btn-primary btn-block">Verify Code</button>
	</form>
	</div>
  </form>
</div>
</cfoutput>