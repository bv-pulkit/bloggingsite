class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_path, notice: "Successfully created account"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end
