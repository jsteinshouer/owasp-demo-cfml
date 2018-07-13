<cfoutput>
<h3>Recipes</h3>
<table class="table">
	<tbody>
		<cfloop array="#prc.recipes#" index="recipe">
		<tr>
			<td><a href="#event.buildLink("recipes.#recipe.getRecipeId()#")#">#recipe.getTitle()#</a></td>
			<td>#recipe.getDescription()#</td>
			<td>#recipe.getUser().getName()#</td>
			<td>
				<a href="#event.buildLink("recipes.#recipe.getRecipeId()#.delete")#" class="btn btn-default btn-sm">Delete</a>
			</td>
		</tr>
		</cfloop>
	</tbody>
</table>
<a href="#event.buildLink("recipes.new")#" class="btn btn-primary">Add Recipe</a>
</cfoutput>