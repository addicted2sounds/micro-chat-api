Rails.application.routes.draw do
  constraints format: :json do
    resources :users, only: [:index, :create]
  end
end
