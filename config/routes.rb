Rails.application.routes.draw do
  root to: redirect('/menu')

  get 'qr', to: 'menu#qr'
  get 'menu', to: 'menu#index'
  get 'queue', to: 'queue#index'
  post 'add_to_cart/:menu_item_id', to: 'menu#add_to_cart', as: :add_to_cart

  resources :orders, except: %i[destroy new create edit] do
    resources :order_items, only: :destroy
  end

  namespace :admin do
    resources :menu_items, except: :show
    resources :orders, only: %i[index show update]
    resources :stats, only: :index
  end
end
