Rails.application.routes.draw do
  constraints format: :json do
    resources :sessions, only: [:create]
    resources :users, only: [:index, :create]
  end
end
