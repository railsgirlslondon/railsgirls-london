RailsgirlsLondon::Application.routes.draw do
  devise_for :users, skip: :registrations

  get "home/index"
  
  resources :cities, only: [:show] do
    resources :registrations, only: [:new, :create]
  end

  namespace :admin do
    resources :cities, only: [:new, :create, :index]
  end

  root :to => 'home#index'
end
