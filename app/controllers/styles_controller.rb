class StylesController < ApplicationController
	before_action :require_user, except: [:show]
	#before_action :require_same_user, only: [:edit, :update]

	def show
		@style = Style.find(params[:id])
		@recipes = @style.recipes.paginate(page: params[:page], per_page: 4)
	end

	def new
		@style = Style.new
	end

	def create
		#binding.pry
		@style = Style.new(style_params)
		if @style.save
			flash[:success] = "Style was created succesfully"
			redirect_to recipes_path
		else
			render 'new'
		end
	end

	private

	def style_params
		params.require(:style).permit(:name)
	end

end