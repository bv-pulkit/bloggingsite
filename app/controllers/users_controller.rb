class UsersController < ApplicationController
	def index
		@users = User.all
		#user_exist_check if !@users.present?
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
		@user = User.where(:id => params[:id]).last
		user_exist_check(@user)
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

	def user_exist_check(user)
		redirect_to new_user_path, notice: "User does not exist. Please Sign Up" if user.nil?
		return false
	end
end
