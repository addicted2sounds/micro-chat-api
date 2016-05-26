Rails.application.routes.draw do
  constraints format: :json do
    resources :sessions, only: [:create]
    resources :users, only: [:index, :create]
    resources :chats, only: [:index, :create, :update] do
      resources :messages, only: [:index, :create]
      resources :unread_messages, only: [:index] do
        delete '', action: 'destroy'
      end
    end
  end
end
