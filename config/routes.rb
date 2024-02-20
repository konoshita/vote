Rails.application.routes.draw do
  resources :answers
  resources :votes , only: [:new, :create, :edit, :index, :show] do
    resources :answers, only: [:new, :create, :index, :show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "votes#index"
end
