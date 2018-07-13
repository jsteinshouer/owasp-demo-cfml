/**
*
* @file  /models/users/UserDAO.cfc
* @author  
* @description
*
*/

component output="false" displayname="UserDAO"  {

	public any function read(user) {

		var q = queryExecute(
			"
				SELECT 
					first_name,
					last_name,
					username,
					two_factor_auth_enabled,
					two_factor_auth_key
				FROM [user]
				WHERE 
					p_user = :userID
			",
			{
				userID = user.getUserId()
			}
		);

		if (q.recordCount) {
			user.setFirstName(q.first_name);
			user.setLastName(q.last_name);
			user.setUsername(q.username);
			user.setTwoFactorAuthenticationEnabled( isBoolean(q.two_factor_auth_enabled) ? q.two_factor_auth_enabled : false );
			user.setTwoFactorAuthenticationKey(q.two_factor_auth_key);
		}
		
		return user;
	}


	public any function create(user) {

		var q = "";
		queryExecute(
			"
				INSERT INTO [user] (
					first_name,
					last_name,
					username,
					password,
					two_factor_auth_enabled,
					two_factor_auth_key
				)
				VALUES (
					:firstName,
					:lastName,
					:username,
					:password,
					:twoFactorAuthenticationEnabled,
					:twoFactorAuthenticationKey
				)

			",
			{
				firstName = user.getFirstName(),
				lastName = user.getLastName(),
				username = user.getUsername(),
				password = user.getPassword(),
				twoFactorAuthenticationEnabled = {cfsqltype="bit", value=user.getTwoFactorAuthenticationEnabled()},
				twoFactorAuthenticationKey = user.getTwoFactorAuthenticationKey()
			},
			{
				result = "q"
			}
		);

		/* Set the id */
		user.setUserId(q.GeneratedKey);
		// user.setId(q.Id);
		/* Remove password for security */
		user.setPassword("");
		
		return user;
	}
	
	public struct function update(user) {

		var q = "";
		queryExecute(
			"
				UPDATE [user]
				SET
					first_name = :firstName,
					last_name = :lastName,
					username = :username,
					two_factor_auth_enabled = :twoFactorAuthenticationEnabled,
					two_factor_auth_key = :twoFactorAuthenticationKey
				WHERE
					p_user = :userID
				
			",
			{
				userID = user.getUserID(),
				firstName = user.getFirstName(),
				lastName = user.getLastName(),
				username = user.getUsername(),
				password = user.getPassword(),
				twoFactorAuthenticationEnabled = {cfsqltype="bit", value=user.getTwoFactorAuthenticationEnabled()},
				twoFactorAuthenticationKey = user.getTwoFactorAuthenticationKey()
			},
			{
				result = "q"
			}
		);
		
		return q;
	}
}