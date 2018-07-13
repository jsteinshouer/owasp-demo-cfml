/**
*
* Recipe Service
* 
* @file  models/recipes/RecipeService.cfc
* @author  
* @description
*
*/
component output="false" displayname="RecipeService"  {

	property name="beanFactory" inject="wirebox";
	property name="recipeDAO" inject="recipes.RecipeDAO";
	property name="recipeGateway" inject="recipes.RecipeGateway";

	public function init(){
		return this;
	}

	public any function get(recipeID = 0) {

		var recipe = beanFactory.getInstance("recipes.Recipe");

		if (arguments.recipeID > 0){
			recipe.setRecipeID(arguments.recipeID);
			recipeDAO.read(recipe);
		}

		return recipe;
	}


	public any function search(q = "") {
		
		return recipeGateway.getAll();
	}


	public any function save(recipe) {

		if (recipe.getRecipeId()){
			recipeDAO.update(recipe);
		}
		else {
			recipeDAO.create(recipe);
		}
		
		return recipe;
	}


	public void function delete(recipe) {
		recipeDAO.delete(recipe);
	}
	
	
	
}