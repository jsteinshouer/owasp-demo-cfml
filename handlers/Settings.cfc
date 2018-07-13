/**
* My Event Handler Hint
*/
component extends="coldbox.system.EventHandler"{

	property name="userService" inject="users.UserService";
	property name="securityService" inject="security.SecurityService";
	property name="oneTimePasswordService" inject="security.OneTimePasswordService";
	
	public void function index(event,rc,prc) {
		event.paramValue("message","");

		prc.user = securityService.getLoggedInUser();


		event.setView(view="settings/index");

	}

	public void function setupTwoFactorAuthentication(event,rc,prc) {
		prc.user = securityService.getLoggedInUser();

		if ( !prc.user.isTwoFactorAuthenticationEnabled() ) {
			prc.user.setTwoFactorAuthenticationKey( oneTimePasswordService.generateKey() );

			userService.save( prc.user );

			prc.qrCodeImage = oneTimePasswordService.getOTPQRCode(
				name = "Recipe Box (#prc.user.getUsername()#)", 
				key = prc.user.getTwoFactorAuthenticationKey() 
			);

			event.setView(view="settings/setup");
		}
		else {
			setNextEvent("settings");
		}
	}

	public void function enableTwoFactorAuthentication(event,rc,prc) {
		prc.user = securityService.getLoggedInUser();
		event.paramValue("passcode","");

		if ( !prc.user.isTwoFactorAuthenticationEnabled() ) {
			var key = prc.user.getTwoFactorAuthenticationKey();

			if ( len( rc.passcode ) && oneTimePasswordService.verify( key, rc.passcode )  ) {

				prc.user.setTwoFactorAuthenticationenabled( true );
				userService.save( prc.user );
				flash.put("message","2-Factor authentication setup successful.");
				
			}
			else {
				prc.user.setTwoFactorAuthenticationEnabled( false );
				prc.user.setTwoFactorAuthenticationKey( "" );
				userService.save( prc.user );
				flash.put("message","2-Factor authentication setup failed.");
			}
		}

		setNextEvent("settings");
	}

	public void function removeTwoFactorAuthentication(event,rc,prc) {

		prc.user = securityService.getLoggedInUser();

		prc.user.setTwoFactorAuthenticationKey( "" );
		prc.user.setTwoFactorAuthenticationenabled( false );

		userService.save( prc.user );


		setNextEvent("settings");

	}

	public void function regenerateTwoFactorAuthenticationKey(event,rc,prc) {

		prc.user = securityService.getLoggedInUser();
		
		prc.user.setTwoFactorAuthenticationKey( oneTimePasswordService.generateKey() );
		prc.user.setTwoFactorAuthenticationenabled( true );

		userService.save( prc.user );

		prc.qrCodeImage = oneTimePasswordService.getOTPQRCode("Recipe Box (#prc.user.getUsername()#)", prc.user.getTwoFactorAuthenticationKey() );

		event.setView(view="settings/setup");

	}

}