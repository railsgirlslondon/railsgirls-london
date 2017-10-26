RailsgirlsLondon::Application.routes.draw do
  root :to   => 'home#index'
  devise_for :users, skip: :registrations

  get 'home' => 'home#index'
  get "/404", to: "errors#not_found"
  get "/london(/:slug)", to: redirect("/"), slug: /.*/

  get "/code_of_conduct" => 'home#code_of_conduct'

  get "/unsubscribe/:member_uuid" => "unsubscribes#new", as: :unsubscribe
  post "/unsubscribe/:member_uuid" => "unsubscribes#create"
  resources :invitation, only: [:show, :update ], param: :token

  resources :events, only: [:show] do
    resources :registrations, only: [:new, :create]
    resources :feedbacks, only: [:new, :show]
  end
  resources :events do
    resource :feedbacks,  only: [ :create ]
  end

  resources :meetups, only: :show

  namespace :admin do
    root :to => 'dashboard#index'
    get '/dashboard' => 'dashboard#index', as: :dashboard

    resources :events do
      resources :invitations, only: [ :show ], :invitable_type => 'Event', :invitable_id => 'event_id' do
        post 'create', on: :collection
        member do
          put 'resend_invite'
        end
      end
      resources :registrations, only: [:show, :new, :create, :update, :destroy] do
        resource :attendance, only: [:create, :destroy]
      end
    end
    resources :meetups
    resources :sponsorships, only: [:create, :destroy, :update]
    resources :coachings, only: [:create, :destroy, :update]
    resources :sponsors
    resources :coaches
    resources :members
  end
end
