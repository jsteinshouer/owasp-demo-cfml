
<table class="table table-condensed">
	<thead>
		<tr>
			<th>Date/Time</th>
			<th>Severity</th>
			<th>Category</th>
			<th>Message</th>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="prc.logs">
		<tr>
			<td>#dateformat(logdate, "short")# #timeformat(logdate, "short")#</td>
			<td>
				<cfif severity eq "warn">
					<span class="label label-warning">WARN</span>
				<cfelseif severity eq "info">
					<span class="label label-info">INFO</span>
				<cfelseif severity eq "error" or severity eq "fatal">
					<span class="label label-danger">#severity#</span>
				<cfelse>
					<span class="label label-default">#severity#</span>
				</cfif>
			</td>
			<td>#category#</td>
			<td>
				<cfif len(message) gt 50>
					#left(message,"50")#...
				<cfelse>
					#message#
				</cfif>
			</td>
		</tr>
		</cfoutput>
	</tbody>
</table>
