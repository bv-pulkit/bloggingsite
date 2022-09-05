Rails.application.routes.draw do
	root "home#index"
	get 'all_articles', to: 'articles#all_articles'
	post "/signin", to: "sessions#create", as: "signin"
	resources :sessions
	resources :passwords
	resources :users do
		resources :articles
	end
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	# Defines the root path route ("/")
	# root "articles#index"
end
