Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :invoices, only: [:index]
    end
  end
end
