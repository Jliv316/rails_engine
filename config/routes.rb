Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
<<<<<<< HEAD
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
=======
        get '/random', to: "random#show"
      end

      resources :merchants, only: [:index, :show] do
      end

      resources :invoices, only: [:index, :show] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/invoice_items', to: 'invoices/invoice_items#index'
        get '/items', to: 'invoices/items#index'
        get '/customer', to: 'invoices/customer#show'
        get '/merchant', to: 'invoices/merchant#show'
      end
>>>>>>> c815ece283d1fc3a42270af001e170fc1189f37f
    end
  end
end
