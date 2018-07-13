/**
*
* @file  models/users/User.cfc
* @author  
* @description
*
*/
component output="false" displayname="User" accessors="true" extends="models.BaseEntity" {

	property name="userID" type="numeric" default=0;
	property name="firstName" type="string";
	property name="lastName" type="string";
	property name="username" type="string";
	property name="password" type="string";
	property name="twoFactorAuthenticationEnabled" type="boolean" default=false;
	property name="twoFactorAuthenticationKey" type="string" default="";

	public function init(){

		return this;
	}


	public any function getName() {
		
		return firstName & " " & lastName;
	}

	public any function isTwoFactorAuthenticationEnabled() {
		
		return (!isNull(twoFactorAuthenticationEnabled) && twoFactorAuthenticationEnabled);
	}
	
	
}