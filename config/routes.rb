Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  
  resources :prototypes do
    resources :comments, only: [:create, :index]
  end

  resources :users, only: [:edit, :update, :show]
 
end
