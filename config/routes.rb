Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  resources :registrations
  resources :tickets
  resources :events
  resources :users
  resources :roles

  get "up" => "rails/health#show", as: :rails_health_check
  post "/auth/login", to: "authentication#login"
end
