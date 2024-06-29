Rails.application.routes.draw do
  root 'api/v1/bases#index'
  namespace :api do
    namespace :v1 do
    end
  end
end
