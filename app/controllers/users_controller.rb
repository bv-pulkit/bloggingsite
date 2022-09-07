class UsersController < ApplicationController
	before_action :require_user_logged_in, only: [:password_edit, :password_update]

	def index
		@users = User.all
		redirect_to new_user_path, notice: "No user found, Please create one" if !@users.present?
	end

	def new
		@user = User.new
	end

	def create
		secure_params = { "email" => user_params[:email], "password" => user_params[:password],
				"password_confirmation" => user_params[:password_confirmation] }
		@user = User.new(secure_params)
		if @user.save!
			redirect_to root_path, notice: "Successfully created account"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
		@user = User.where(:id => params[:id]).last
		redirect_to new_user_path, notice: "User does not exist. Please Sign Up" if @user.nil?
	end

	def edit_password
	end

	def update_password
		secure_params = { "password" => user_params[:password],
				"password_confirmation" => user_params[:password_confirmation] }
		if Current.user.update!(secure_params)
			redirect_to root_path, notice: 'Password Updated'
		else
			flash.now[:alert] = 'Passwords do not match'
			render :edit, status: :unprocessable_entity
		end
	end

	def new_session
	end

	def create_session
		user = User.where(:email => params[:email]).last
		if user.present? && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to root_path, notice: 'Logged in successfully'
		else
			flash.now[:alert] = 'Invalid email or password'
			render :new, status: :unprocessable_entity
		end
	end

	def destroy_session
		session[:user_id] = nil
		redirect_to root_path, notice: 'Logged Out'
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end
