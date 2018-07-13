<cfset html.addAsset("https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.9.1/underscore-min.js")>
<cfif getSetting( "environment" ) eq "development">
	<cfset html.addAsset("https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js")>	
<cfelse>
	<cfset html.addAsset("https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.min.js")>
</cfif>
<cfset html.addAsset("/assets/js/components/PasswordMeter.js")>
<cfset html.addAsset("/assets/css/passwordMeter.css")>
<cfset html.addAsset("/assets/js/signup.js")>
<cfoutput>
<div class="container" style="margin-top: 30px">
	<form class="form-signin" id="form-signin" role="form" method="post">
		<h2>Sign Up</h2>
		<cfif len(rc.message)>
			<div class="alert alert-warning">#encodeForHTML( event.getValue("message","") )#</div>
		</cfif>
		<input type="text" name="firstName" class="form-control input-lg" placeholder="First Name" required autofocus value="#encodeForHTMLAttribute(rc.firstName)#">
		<input type="text" name="lastName" class="form-control input-lg" placeholder="Last Name" required value="#encodeForHTMLAttribute(rc.lastName)#">
		<input type="text" name="username" class="form-control input-lg" placeholder="Username" required value="#encodeForHTMLAttribute(rc.username)#">
		<div class="input-group">
			<input :type="passwordFieldType" name="password" id="password" v-model="password" class="form-control input-lg" placeholder="Password" required>
			<span class="input-group-addon pointer" @click="showPassword = !showPassword">
				<span class="glyphicon" :class="{'glyphicon-eye-open': !showPassword, 'glyphicon-eye-close': showPassword}" aria-hidden="true"></span>
			</span>
        </div>
        <password-meter :password="password" target="##password" estimate-endpoint="/security/estimatePasswordStrength"></password-meter>

		<button class="btn btn-lg btn-primary btn-block">Sign Up</button>
  </form>
</div>
</cfoutput>