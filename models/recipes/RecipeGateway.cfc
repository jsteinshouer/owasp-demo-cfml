/**
*
* @file  models/recipes/RecipeGateway.cfc
* @author  
* @description
*
*/

component output="false" displayname="ReceipeGateway"  {

	property name="userService" inject="users.UserService";
	property name="beanFactory" inject="wirebox";

	public any function getAll() {

		var recipes = [];


		var q = queryExecute(
			"
				SELECT *
				FROM recipe
			"
		);

		if (q.recordCount) {

			for (var item in q) {
				var recipe = beanFactory.getInstance("recipes.Recipe");
				recipe.setRecipeId(item.p_recipe);
				recipe.setTitle(item.title);
				recipe.setDescription(item.description);
				recipe.setIngredients(item.ingredients);
				recipe.setDirections(item.directions);
				recipe.setUser(userService.get(item.f_user));
				recipes.append(recipe);
			}
		}
		
		return recipes;
	}
	
	
	
	
	
}