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
      end
      namespace :items do
        get '/most_revenue', to: "most_revenue#index"
        get '/most_items', to: "most_items#index"
        get '/:id/best_day', to: "best_day#show"
        get '/random', to: "random#show"
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
      end
      namespace :invoices do
        get '/random', to: "random#show"
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
      end
      resources :customers, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end
end
