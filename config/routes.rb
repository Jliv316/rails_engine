Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/customers_with_pending_invoices', to:'invoice_analysis#index'
        get '/random', to: 'random#show'
      end


      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :customers do
        get '/random', to: 'random#show'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      resources :merchants, only: [:index, :show] do
        get '/revenue', to: 'merchants/revenue#show'
        get '/items', to: 'merchants/items#index'
        get '/invoices', to: 'merchants/invoices#index'
        get '/favorite_customer', to: 'merchants/favorite_customer#show'
      end


      resources :invoices, only: [:index, :show] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/invoice_items', to: 'invoices/invoice_items#index'
        get '/items', to: 'invoices/items#index'
        get '/customer', to: 'invoices/customer#show'
        get '/merchant', to: 'invoices/merchant#show'
      end

      resources :items, only: [:index, :show] do

      end

      resources :invoice_items, only: [:index, :show] do

      end

      resources :customers, only: [:index, :show] do
      end

      resources :transactions, only: [:index, :show] do
      end

    end
  end
end
