RailsgirlsLondon::Application.routes.draw do
  devise_for :users, skip: :registrations

  namespace :admin do
    resources :cities, only: [:new, :create, :index]
    resources :events
    resources :event_sponsorships, only: [:create, :destroy]
    resources :event_coachings, only: [:create, :destroy]
    resources :sponsors
    resources :coaches

    get '/dashboard' => 'dashboard#index', as: :dashboard
  end

  get "/404", to: "errors#not_found"

  resources :cities, path: "", only: [:show] do
    resources :events, only: [:show] do
      resources :registrations, only: [:new, :create]
    end
  end

  root :to => 'home#index'
end
