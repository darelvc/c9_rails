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

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params)
			flash[:success] = "Your recipe was updated successfully!"
			redirect_to recipe_path(@recipe)
		else
			render 'edit'
		end
	end

	private

	def recipe_params
		params.require(:recipe).permit(:name, :summary, :description)
	end

end