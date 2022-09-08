Rails.application.routes.draw do
	devise_for :views
	devise_for :users
	devise_scope :user do
		get '/users/sign_out', to: 'devise/sessions#destroy'
	end
	get 'home/index'
	root "home#index"
	resources :articles
	resources :users do
		resources :articles
	end
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	# Defines the root path route ("/")
	# root "articles#index"
end
