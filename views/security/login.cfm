<cfoutput>
<div class="container" style="margin-top: 30px">
	<form class="form-signin" role="form" method="post" action="#event.buildLink("login")#">
		<h2>Sign-In</h2>
		<cfif len(prc.message)>
			<div class="alert alert-warning">#prc.message#</div>
		</cfif>
		<input type="text" name="username" class="form-control input-lg" placeholder="Username" required autofocus>
		<input type="password" name="password" class="form-control input-lg" placeholder="Password" required>
		<cfif prc.RECAPTCHA_ENABLED>
			<div class="g-recaptcha" data-sitekey="#prc.RECAPTCHA_SITE_KEY#"></div>
			<cfset html.addAsset("https://www.google.com/recaptcha/api.js")>
		</cfif>
		<button class="btn btn-lg btn-primary btn-block">Login</button>
  </form>
</div>

</cfoutput>