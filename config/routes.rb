Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/:id/favorite_merchant', to: "favorite_merchant#show"
      end
      namespace :merchants do
        get '/most_revenue', to: "most_revenue#index"
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/most_items', to: "most_items#index"
        get '/revenue', to: "revenue#index"
        get '/:id/revenue', to: "revenue#show"
        get '/:id/favorite_customer', to: "favorite_customer#show"
        get "/:id/items", to: "items#index"
        get "/:id/invoices", to: "invoices#index"
      end
      namespace :items do
        get '/most_revenue', to: "most_revenue#index"
        get '/most_items', to: "most_items#index"
        get '/:id/best_day', to: "best_day#show"
        get '/random', to: "random#show"
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/:id/invoice_items', to: "invoice_items#show"
        get '/:id/merchant', to: "merchants#show"
      end
      namespace :invoices do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/:id/transactions', to: "transactions#index"
        get '/:id/invoice_items', to: "invoice_items#index"
        get '/:id/items', to: "items#index"
        get '/:id/customer', to: "customer#show"
        get '/:id/merchant', to: "merchants#show"
      end
      namespace :invoice_items do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/:id/invoice', to: "invoice#show"
        get '/:id/item', to: "item#show"
      end
      namespace :transactions do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/:id/invoice', to: "invoices#show"
      end
      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
