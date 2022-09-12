class UsersController < ApplicationController
	def index
		@users = User.all
		redirect_to new_user_path, notice: "No user found, Please create one" if !@users.present?
	end

	def new
		@user = User.new
	end

	def create
		secure_params = { "email" => user_params[:email], "password" => user_params[:password], "password											_confirmation" => user_params[:password_confirmation] }
		@user = User.new(user_params)
		if @user.save
			redirect_to root_path, notice: "Successfully created account"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
		@user = User.where(:id => params[:id]).last
		redirect_to new_user_path, notice: "User does not exist. Please Sign Up" if @user.nil?
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end
