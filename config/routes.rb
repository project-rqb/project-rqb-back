# frozen_string_literal: true

Rails.application.routes.draw do
  root 'api/v1/bases#index'
  namespace :api do
    namespace :v1 do
      get 'auth/:provider/callback', to: 'sessions#create'

      resources :questions, only: [:index, :create] do
        resources :answers, only: [:create]
      end
    end
  end
end
