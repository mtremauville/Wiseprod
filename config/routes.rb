Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  resources :products, only: [:index, :show]
  resources :consultations, only: [:new, :create, :show] do
    collection do
      get :device_type
      post :device_type, action: :save_device_type
      get :usage
      post :usage, action: :save_usage
      get :budget
      post :budget, action: :save_budget
      get :mobility
      post :mobility, action: :save_mobility
      get :priority
      post :priority, action: :save_priority
    end
    member do
      post :generate_argument
    end
  end

  root "consultations#device_type"

  get "demo_login", to: "products#demo_login"
end
