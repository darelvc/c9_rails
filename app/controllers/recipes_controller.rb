class RecipesController < ApplicationController

	def index
		#@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
		@recipes = Recipe.paginate(page: params[:page], per_page: 6)
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

	def like
		#binding.pry
		@recipe = Recipe.find(params[:id])
		like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
		if like.valid?			
			flash[:success] = "Your selection was successfully!"
			redirect_to	:back
		else
			flash[:danger] = "You can only like/dislike a recipe once"
			redirect_to	:back
		end
	end

	private

	def recipe_params
		params.require(:recipe).permit(:name, :summary, :description, :picture)
	end

end