RailsgirlsLondon::Application.routes.draw do
  devise_for :users

  get "home/index"

  root :to => 'home#index'
end
