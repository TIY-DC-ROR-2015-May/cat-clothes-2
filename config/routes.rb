Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :omniauth_callbacks }

  resources :items # do
  #   member do
  #     post :buy
  #   end
  # end

  resource :cart, only: [:update]

  root to: 'items#index'
end
