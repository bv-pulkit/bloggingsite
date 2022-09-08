class ArticlesController < ApplicationController
	before_action :load_user
	before_action :load_article, except: [:index, :new, :create]

	def index
		@articles = @user.articles
	end

	def new
		@article = Article.new
	end

	def create
		secure_params = { "title" => article_params[:title], "body" => article_params[:body] }
		@article = @user.articles.new(secure_params)
		if @article.save!
			redirect_to user_path(@user)
		else
			render :new, status: :unprocessable_entity
		end
	end

	def update
		secure_params = { "title" => article_params[:title], "body" => article_params[:body] }
		if @article.update!(secure_params)
			redirect_to user_path(@user)
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@article.destroy!
		redirect_to user_path(@user), status: :see_other;
	end

	private 
	def article_params
		params.require(:article).permit(:title, :body)
	end

	def load_user
		@user = current_user
		user_not_found if !@user.present?
	end

	def load_article
		@article = Article.where(:id => params[:id]).last if @user
		article_not_found if !@article.present?
	end

	def article_not_found
		redirect_to new_user_article_path(@user), notice:"Article dont Exist, Create new one"
		return false 
	end

	def user_not_found
		redirect_to new_user_path, notice: "User does not exist. Please Sign Up"
		return false 
	end
end
