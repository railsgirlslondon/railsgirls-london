RailsgirlsLondon::Application.routes.draw do
  devise_for :users

  get "home/index"
  root :to => "home#index"

  get  "/:slug" => "host_cities#show", as: :city

end
