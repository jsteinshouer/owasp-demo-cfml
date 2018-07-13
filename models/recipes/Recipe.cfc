/**
*
* Recipe Entity
* 
* @file  models/recipes/Recipe.cfc
* @author  Jason Steinshouer
* @description Recipe bean
*
*/
component output="false"  accessors="true" extends="models.BaseEntity" {

	property name="recipeID" type="numeric";
	property name="title" type="string";
	property name="description" type="string";
	property name="ingredients" type="string";
	property name="directions" type="string";
	property name="user" type="any";

	/**
	* Constructor
	* 
	* @user.inject users.User
	* 
	* @recipeId.hint Recipe identifier
	* @title.hint Recipe Title
	* @description.hint Recipe description
	* @directions.hint Receipe directions
	* @user.hint users.User Recipe owner
	*/
	public function init(
		recipeID = 0,
		title = "",
		description = "",
		ingredients = "",
		directions = "",
		user
	){
		setRecipeID(arguments.recipeID);
		setTitle(arguments.title);
		setDescription(arguments.description);
		setIngredients(arguments.ingredients);
		setDirections(arguments.directions);
		setUser(arguments.user);


		return this;
	}
	
	
}