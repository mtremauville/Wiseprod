Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords" }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products

  resources :customers, only: [:new, :create, :show] do
    collection do
      get :search
    end
  end

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
