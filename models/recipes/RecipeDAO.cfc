/**
*
* @file  models/recipes/RecipeDAO.cfc
* @author  
* @description
*
*/

component output="false" displayname=""  {

	property name="userService" inject="users.UserService";

	public any function read(recipe) {

		var q = queryExecute(
			"
				SELECT *
				FROM recipe
				WHERE 
					p_recipe = :recipeId
			",
			{
				recipeId = recipe.getRecipeId()
			}
		);

		if (q.recordCount) {
			recipe.setTitle(q.title);
			recipe.setDescription(q.description);
			recipe.setIngredients(q.ingredients);
			recipe.setDirections(q.directions);
			recipe.setUser(userService.get(q.f_user));
		}
		
		return recipe;
	}

	public any function create(recipe) {
		var q = "";
		queryExecute(
			"
				INSERT INTO recipe (
					title,
					description,
					ingredients,
					directions,
					f_user
				)
				VALUES (
					:title,
					:description,
					:ingredients,
					:directions,
					:userId
				);
			",
			{
				title = recipe.getTitle(),
				description = recipe.getDescription(),
				ingredients = recipe.getIngredients(),
				directions = recipe.getDirections(),
				userId = recipe.getUser().getUserId()
			},
			{
				result = "q"
			}
		);

		/* Set the id */
		recipe.setRecipeId(q.GeneratedKey);
		
		return recipe;
	}


	public any function update(recipe) {

		var q = queryExecute(
			"
				UPDATE recipe 
				SET
					title = :title,
					description = :description,
					ingredients = :ingredients,
					directions = :directions,
					f_user = :userId
				WHERE
					p_recipe = :recipeId
			",
			{
				recipeId = recipe.getRecipeId(),
				title = recipe.getTitle(),
				description = recipe.getDescription(),
				ingredients = recipe.getIngredients(),
				directions = recipe.getDirections(),
				userId = recipe.getUser().getUserId()
			}
		);
		
		return recipe;
	}


	public void function delete(recipe) {
		
		var q = queryExecute(
			"
				DELETE
				FROM recipe
				WHERE 
					p_recipe = :recipeId
			",
			{
				recipeId = recipe.getRecipeId()
			}
		);
	}
	
	
}