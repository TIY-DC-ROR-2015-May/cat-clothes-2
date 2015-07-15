require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :omniauth_callbacks }

  resources :items do
    member do
      post :buy
    end
  end

  resource :cart, only: [:update] do
    member do
      post :checkout
    end
  end

  resources :invoices, only: [:show] do 
    resources :charges, only: [:new, :create]
  end

  # authenticate :user, lambda { |u| u.admin? } do
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'items#index'
end
