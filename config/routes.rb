Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/customers_with_pending_invoices', to:"invoice_analysis#index"
      end

      namespace :invoices do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
      end
      
      resources :invoices, only: [:index, :show] do
        resources :transactions, only: [:index, :show]
      end

      resources :merchants, only: [:index, :show]
    end
  end
end
