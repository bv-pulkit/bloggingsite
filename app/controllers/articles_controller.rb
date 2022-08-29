class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def show
		@user = User.find(params[:user_id])
		@article = @user.articles.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def create
		@user = User.find(params[:user_id])
		@article = @user.articles.new(article_params)

		if @article.save
			redirect_to user_path(@user)
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
		@user = User.find(params[:user_id])
		@article = @user.articles.find(params[:id])
	end

	def update
		@user = User.find(params[:user_id])
		@article = @user.articles.find(params[:id])

		if @article.update(article_params)
			redirect_to user_path(@user)
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@article = @user.articles.find(params[:id])
		puts "ready to destroy"
		@article.destroy

		redirect_to user_path(@user), status: :see_other;
	end

	private 
	def article_params
		params.require(:article).permit(:title, :body)
	end
end
