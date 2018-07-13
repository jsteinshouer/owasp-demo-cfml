<cfsilent>
	<cfset addAsset("/assets/js/share.js")>
</cfsilent>
<cfoutput>
<div class="container" style="margin-top: 30px">
  <h1>#prc.recipe.getTitle()#</h1>
  <p class="text-muted">#prc.recipe.getDescription()#</p>
  <div ng-show="recipe.user">
    <h5><strong>Entered By:</strong> #prc.recipe.getUser().getName()#</h5>
  </div>
  <div>
    <!--- <h5><strong>Tags:</strong> {{recipe.tags.join()}}</h5> --->
  </div>
  <div>
    <h5><strong>Ingredients</strong></h5>
    <pre>#prc.recipe.getIngredients()#</pre>
  </div>
  <div>
    <h5><strong>Directions</strong></h5>
    <pre>#prc.recipe.getDirections()#</pre>
  </div>
	<a class="btn btn-default btn-lg" href="#event.buildLink("recipes.#prc.recipe.getRecipeId()#.edit")#">Edit</a>
</div>

</cfoutput>