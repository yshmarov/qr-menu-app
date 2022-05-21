Rails.application.routes.draw do
  root to: redirect('/menu')

  get 'menu', to: 'menu#index'
  get 'queue', to: 'queue#index'
  post 'add_to_cart/:menu_item_id', to: 'menu#add_to_cart', as: :add_to_cart

  resources :orders, except: %i[destroy new create] do
    resources :order_items, only: :destroy
  end

  resources :menu_items, except: :show

  namespace :admin do
    resources :orders, except: %i[destroy new create]
  end
end
