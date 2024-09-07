# frozen_string_literal: true

Rails.application.routes.draw do
  root 'api/v1/bases#index'
  namespace :api do
    namespace :v1 do
      get 'auth/:provider/callback', to: 'sessions#create'
      get 'auth/me', to: 'sessions#me'

      resources :questions, only: %i[index create] do
        resources :answers, only: [:create]
      end
      get 'questions/all_count', to: 'questions#count_all_questions'
      post 'questions/ai_review', to: 'questions#ai_review'
    end
  end
end
