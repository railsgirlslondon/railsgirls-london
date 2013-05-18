RailsgirlsLondon::Application.routes.draw do
  devise_for :users, skip: :registrations

  get "home/index"
  get "cities/:id" => "cities#show", :as => :city

  namespace :admin do
    resources :cities, only: [:new, :create, :index]
  end

  root :to => 'home#index'
end
