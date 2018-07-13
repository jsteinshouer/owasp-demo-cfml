<cfoutput><div class="container" style="margin-top: 30px">
	<h2>Settings</h2>
	<div class="row">
		<div class="col-sm-6">
		<cfif len(rc.message)>
			<div class="alert alert-warning">#event.getValue("message","")#</div>
		</cfif>
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th>2-Step Authentication</th>
					<td>
						<cfif prc.user.istwoFactorAuthenticationEnabled()>
							<a href="#event.buildLink("settings.removeTwoFactorAuthentication")#">Remove</a>
						<cfelse>
							<a href="#event.buildLink("settings.setupTwoFactorAuthentication")#">Enable</a>
						</cfif>
					</td>
				</tr>
				<cfif prc.user.istwoFactorAuthenticationEnabled()>
					<tr>
					<th>2-Step Authentication Key</th>
					<td>
						<a href="#event.buildLink("settings.regenerateTwoFactorAuthenticationKey")#">Regenerate</a>
					</td>
				</tr>
				</cfif>
			</tbody>
		</table>
		</div>
	</div>
</div></cfoutput>