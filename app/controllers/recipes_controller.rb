class RecipesController < ApplicationController
	before_action :set_recipe, only: [:edit, :update, :show, :like]
	before_action :require_user, except: [:show, :index]
	before_action :require_same_user, only: [:edit, :update]

	def index
		#@recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
		@recipes = Recipe.paginate(page: params[:page], per_page: 6)
	end

	def show
		#@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		# @recipe = Recipe.new(recipe_params)
		# chef = Chef.new(chefname: "Mariia", email: "darelvc@gmail.com")
		# @recipe.chef = chef
		
		#@chef = Chef.last
		#@recipe = @chef.recipes.build(recipe_params)

		@recipe = Recipe.new(recipe_params)
		@recipe.chef = current_user

		if @recipe.save 
			flash[:success] = "Your recipe was created successfully!"
			redirect_to @recipe # notice: "Succesfully created new recipe"
		else
			render 'new'
		end
	end

	def edit
		#@recipe = Recipe.find(params[:id])
	end

	def update
		#@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params)
			flash[:success] = "Your recipe was updated successfully!"
			redirect_to recipe_path(@recipe)
		else
			render 'edit'
		end
	end

	def like
		#binding.pry
		like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
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

	def set_recipe
		@recipe = Recipe.find(params[:id])
	end

	def require_same_user
		if current_user != @recipe.chef
			flash[:danger] = "You can only edit your recipe"
			redirect_to recipes_path
		end
	end

end