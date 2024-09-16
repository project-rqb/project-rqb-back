# frozen_string_literal: true

Rails.application.routes.draw do
  root 'api/v1/bases#index'
  namespace :api do
    namespace :v1 do
      get 'auth/:provider/callback', to: 'sessions#create'
      get 'auth/me', to: 'sessions#me'

      get 'questions/all_count', to: 'questions#count_all_questions'
      resources :questions, only: %i[index create show] do
        resources :answers, only: %i[create index]
        member do
          patch 'close', to: 'questions#close'
          get 'tags', to: 'questions#tags'
        end
      end
      get 'questions/all_count', to: 'questions#count_all_questions'
      post 'questions/ai_review', to: 'questions#ai_review'

      resources :terms, only: %i[index]
      resources :users, only: %i[show update] do
        member do
          get 'questions', to: 'users#questions'
          get 'all_questions_count', to: 'users#all_questions_count'
        end
      end
    end
  end
end
