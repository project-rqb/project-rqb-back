# frozen_string_literal: true

Rails.application.routes.draw do
  root 'api/v1/bases#index'
  namespace :api do
    namespace :v1 do
      get 'auth/:provider/callback', to: 'sessions#create'

      resources :questions, only: [:index, :create] do
        resources :answers, only: [:create]
      end
      get 'questions/all_count', to: 'questions#count_all_questions'
    end
  end
end
