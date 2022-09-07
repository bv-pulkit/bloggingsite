class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.where(:email => params[:email]).last
		if user.present? && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to root_path, notice: 'Logged in successfully'
		else
			flash.now[:alert] = 'Invalid email or password'
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: 'Logged Out'
	end
end
