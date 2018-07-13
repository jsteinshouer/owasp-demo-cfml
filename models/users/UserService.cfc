/**
*
* @file  models/users/UserService.cfc
* @author  
* @description
*
*/
component output="false" displayname=""  {

	property name="beanFactory" inject="wirebox";
	property name="userDAO" inject="users.UserDAO";


	public any function get(userID = 0) {

		var user = beanFactory.getInstance("users.User");

		if (arguments.userID > 0){
			user.setUserId(arguments.userID);
			userDAO.read(user);
		}

		return user;
	}


	public any function save(user) {

		if (user.getUserId() == 0) {
			userDAO.create(user);
		}
		else {
			userDAO.update(user);
		}

		return user;
	}
	

	public any function hasUsers() {
		
		var q = queryExecute(
			"
				SELECT *
				FROM [user]
	
			"
		);

		return (q.recordCount > 0);
	}
	
	
}