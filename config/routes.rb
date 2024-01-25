Rails.application.routes.draw do
  resources :answers
  resources :questions , only: [:new, :create, :edit, :index, :show, :destroy] do
    resources :answers, only: [:new, :create, :index, :show, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "questions#index"
end
