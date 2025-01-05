Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root to: redirect("/shop")

  get "qr", to: "shop#qr"
  get "shop", to: "shop#index"
  get "queue", to: "queue#index"
  post "add_to_cart/:product_id", to: "shop#add_to_cart", as: :add_to_cart

  resources :orders, except: %i[destroy new create edit] do
    resources :order_items, only: :destroy
  end

  namespace :admin do
    resources :products, except: :show
    resources :orders, only: %i[index show update]
    resources :stats, only: :index
  end
end
