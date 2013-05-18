RailsgirlsLondon::Application.routes.draw do
  devise_for :users

  get "home/index"
  get "cities/:id" => "cities#show", :as => :city

  root :to => 'home#index'
end
