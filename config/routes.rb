Rails.application.routes.draw do
  resources :persons do
    resources :messages
  end

  resource :communications, only: [:create]
end
