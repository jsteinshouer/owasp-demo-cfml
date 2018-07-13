Vue.component('password-meter', {

	template: ' <div id="password-strength-meter" @click="showInfo">\
		<meter max="4" :value="score"></meter> \
        <span class="text-muted">Password Strength: {{strength}} \
        	<span class="glyphicon glyphicon-info-sign" v-if="info"></span> \
        </span> \
	</div>',
	props: ["password","target", "estimateEndpoint"],
	data: function() {
		return {
			score: 0,
			showHelp: true,
			info: ""
		}
	},
	computed: {
		strength: function() {
			switch( this.score ) {
				case 0: case 1:
					return "Weak";
				break;
				case 2:
					return "Medium";
				break;
				case 3:
					return "Good";
				break;
				case 4:
					return "Great";
				break;
			}
		}
	},
	created: function() {
		this.debouncedGetEstimate = _.debounce(this.getEstimate, 200);
	},
	watch: {
		password: function() {
			this.debouncedGetEstimate();
		}
	},
	methods: {
		showInfo: function() {
			var vm = this;

			if (vm.info) {
			
				$( this.target ).popover({
					content: function() {
						return vm.info;
					},
					title: vm.strength,
					trigger: "manual",
					container: 'body'
				});
				$( this.target ).popover("toggle");
			}
		}, 
		getEstimate: function() {
			var vm = this;

			$.ajax({
				url: this.estimateEndpoint,
				data: { password: this.password },
				dataType: "json"
			}).done(function(estimate) {
				vm.score = estimate.score;
				if (estimate.warning && estimate.warning.length && vm.score < 3) {
					vm.info = estimate.warning + "\n";
					vm.info += "\n\n" + estimate.suggestions.join("\n");
				}
				else if (estimate.suggestions.length && vm.score < 3) {
					vm.info = estimate.suggestions.join("\n");
				}
				else {
					vm.info = "";
				}
				$( vm.target ).popover("destroy");
			});
		}
	}

});