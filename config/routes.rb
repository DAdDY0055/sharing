Rails.application.routes.draw do
  root 'top#index'
  get 'users/favorite', to: 'users#favorite'
  resources :favorites, only: [:create, :destroy]
resources :blogs do
    collection do
      post :confirm
    end
  end

resources :users do
  collection do
    get :check
  end
end

 resources :sessions, only: [:new, :create, :destroy]
 resources :users, only: [:new, :create, :show, :index]
end
