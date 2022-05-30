Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resource :products, only: :index
  resource :promotions, only: :index
  resource :purchases, only: :create
end
