RailsgirlsLondon::Application.routes.draw do
  devise_for :users, skip: :registrations

  get "home/index"

  namespace :admin do
    resources :cities, only: [:new, :create, :index]
    resources :events
  end

  match "/404", to: "errors#not_found"

  resources :cities, path: "", only: [:show] do
    resources :events, only: [ ] do
      resources :registrations, only: [:new, :create]
    end
  end

  root :to => 'home#index'
end
