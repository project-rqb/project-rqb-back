# frozen_string_literal: true

Rails.application.routes.draw do
  root 'api/v1/bases#index'
  namespace :api do
    namespace :v1 do
      get 'auth/:provider/callback', to: 'sessions#create'
      get 'auth/me', to: 'sessions#me'

      resources :questions, only: %i[index create show] do
        resources :answers, only: %i[create index]
        member do
          patch 'close', to: 'questions#close'
          get 'tags', to: 'questions#tags'
        end
      end
      get 'questions/all_count', to: 'questions#count_all_questions'
    end
  end
end

