Rails.application.routes.draw do
	root "home#index"
	get 'all_articles', to: 'articles#all_articles'
	get "/signin", to: "users#new_session"
	post "/signin", to: "users#create_session"
	resources :users do
		resources :articles
	end
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	# Defines the root path route ("/")
	# root "articles#index"
end
