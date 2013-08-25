RailsgirlsLondon::Application.routes.draw do

  devise_for :users, skip: :registrations

  namespace :admin do
    resources :cities, only: [:show, :new, :create, :index] do
      resources :meetings do
        resources :invitations, only: [ :show ], :invitable_type => 'Meeting', :invitable_id => 'meeting_id' do
          post 'create', on: :collection
        end
      end

      resources :events, only: [:show] do
        post "/convert_members" => "events#convert_attendees_to_members!", as: :convert_members
      end

      resources :members

    end

    resources :events do
      resources :registrations, only: [:show, :new, :create] do
        resource :attendance, only: [:create, :destroy]
      end
    end

    resources :sponsorships, only: [:create, :destroy, :update]

    resources :coachings, only: [:create, :destroy, :update]
    resources :sponsors
    resources :coaches

    root :to => 'dashboard#index'

    get '/dashboard' => 'dashboard#index', as: :dashboard
  end

  get "/404", to: "errors#not_found"

  get "/:id/sponsor" => "cities#sponsor", as: :city_sponsor

  get "/unsubscribe/:member_uuid" => "unsubscribes#new", as: :unsubscribe
  post "/unsubscribe/:member_uuid" => "unsubscribes#create"

  resources :invitation, only: [:show, :update ], param: :token

  resources :cities, path: "", only: [:show] do
    resources :events, only: [:show] do
      resources :registrations, only: [:new, :create]
    end
    resources :meetings, only: [:show, :index]
  end

  root :to => 'home#index'
end
