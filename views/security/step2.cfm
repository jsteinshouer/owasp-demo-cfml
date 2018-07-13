<cfoutput>
<div class="container" style="margin-top: 30px">
	<form class="form-signin" role="form" method="post" action="#event.buildLink("login/step2")#">
		<h2>Sign-In</h2>
		<cfif structKeyExists(prc,"message")>
			<div class="alert alert-warning">#prc.message#</div>
		</cfif>
		<input type="text" name="passcode" class="form-control input-lg" placeholder="Passcode" required>
		<span id="helpBlock" class="help-block">Open the two-factor authentication app on your device to view your authentication code and enter it here.</span>
		<button class="btn btn-lg btn-primary btn-block">Verify Code</button>
  </form>
</div>
</cfoutput>