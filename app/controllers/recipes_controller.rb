class RecipesController < ApplicationController

	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		# @recipe = Recipe.new(recipe_params)
		# chef = Chef.new(chefname: "Marina", email: "darelvc@gmail.com")
		# @recipe.chef = chef
		@chef = Chef.last
		@recipe = @chef.recipes.build(recipe_params)

		if @recipe.save 
			flash[:success] = "Your recipe was created successfully!"
			redirect_to @recipe # notice: "Succesfully created new recipe"
		else
			render 'new'
		end
	end

	private

	def recipe_params
		params.require(:recipe).permit(:name, :summary, :description)
	end

end