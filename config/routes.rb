RailsgirlsLondon::Application.routes.draw do
  root :to   => 'home#index'
  devise_for :users, skip: :registrations

  get 'home' => 'home#index'
  get "/404", to: "errors#not_found"

  #get "/:id/sponsor" => "home#sponsors", as: :city_sponsor

  get "/unsubscribe/:member_uuid" => "unsubscribes#new", as: :unsubscribe
  post "/unsubscribe/:member_uuid" => "unsubscribes#create"
  resources :invitation, only: [:show, :update ], param: :token

  resources :events, only: [:show] do
    resources :registrations, only: [:new, :create]
    resources :feedback, only: [:new, :show]
  end
  resources :events do
    resource :feedback,  only: [ :create ]
  end

  namespace :admin do
    root :to => 'dashboard#index'
    get '/dashboard' => 'dashboard#index', as: :dashboard

    resources :events do
      resources :registrations, only: [:show, :new, :create] do
        resource :attendance, only: [:create, :destroy]
      end
    end

    resources :sponsorships, only: [:create, :destroy, :update]
    resources :coachings, only: [:create, :destroy, :update]
    resources :sponsors
    resources :coaches
    resources :members
  end
end
