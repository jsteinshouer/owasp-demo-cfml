$(document).ready(function() {

	var app = new Vue({
		el: '#form-signin',
		data: {
			password: "",
			showPassword: false
		},
		computed: {
			passwordFieldType: function() {
				if ( this.showPassword ) {
					return "text";
				}
				else {
					return "password";
				}
			}
		}
	});
	
});