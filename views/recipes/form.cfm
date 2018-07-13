<cfoutput>
<div class="container" style="margin-top: 30px">
<form role="form" action="#event.buildLink("recipes.#prc.recipe.getRecipeId()#.save")#" method="POST">
  <div class="form-group">
    <label for="title">Title</label>
    <input type="text" class="form-control input-lg" name="title" required value="#prc.recipe.getTitle()#" />
  </div>
  <div class="form-group">
    <label for="description">Description</label>
    <input type="text" class="form-control input-lg" name="description" size="150" value="#prc.recipe.getDescription()#" />
  </div>
  <div class="form-group">
    <label for="ingredients">Ingredients</label>
    <textarea name="ingredients" class="form-control" rows="7" required>#prc.recipe.getIngredients()#</textarea>
  </div>
  <div class="form-group">
    <label for="directions">Directions</label>
    <textarea name="directions" class="form-control" rows="7" required>#prc.recipe.getDirections()#</textarea>
  </div>
 <!---  <div class="form-group">
    <label for="tags">Tags</label>
    <tags-input ng-model="recipe.tags"></tags-input>
  </div> --->
  <!--- <input type="hidden" name="id" value="#prc.recipe.getId()#" /> --->
  <button type="submit" class="btn btn-default">Save</button>

 <!---  <span class="text-success" style="margin-left: 5px"><strong>Saved!</strong> The recipe was saved successfully.</span>
  <span class="text-danger" style="margin-left: 5px" ng-show="saveError"><strong>Error!</strong> </div> --->
</form>
</div>
</cfoutput>