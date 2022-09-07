class ArticlesController < ApplicationController
	before_action :load_user, except: :all_articles
	before_action :load_article, except: [:index, :new, :create, :all_articles]

	def index
		@articles = @user.articles
	end

	def show
	end

	def all_articles
		@article = Article.all
	end

	def new
		@article = Article.new
	end

	def create
		@article = @user.articles.new(article_params)
		if @article.save!
			redirect_to user_path(@user)
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	def update
		if @article.update!(article_params)
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
		@user = User.where(:id => params[:user_id]).last
		user_not_exists if !@user.present?
	end

	def load_article
		@article = @user.articles.where(:id => params[:id]).last if @user
		article_not_exists if !@article.present?
	end

	def article_not_exists
		redirect_to new_user_article_path, notice:"Article dont Exist, Create new one"
		return false 
	end

	def user_not_exists
		redirect_to new_user_path, notice: "User does not exist. Please Sign Up"
		return false 
	end
end
