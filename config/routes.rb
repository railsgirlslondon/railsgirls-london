RailsgirlsLondon::Application.routes.draw do
  devise_for :users, skip: :registrations

  get "home/index"

  namespace :admin do
    resources :cities, only: [:new, :create, :index]
    resources :events
  end

  resources :cities, path: "", only: [:show] do
    resources :events do
      resources :registrations, only: [:new, :create]
    end
  end

  root :to => 'home#index'
end
