Rails.application.routes.draw do
  get 'menu', to: 'menu#index'
  get 'queue', to: 'queue#index'
  resources :orders do
    collection do
      get :all
    end
    resources :order_items, only: :destroy
  end
  resources :menu_items do
    post :add_to_cart
  end
  root to: redirect('/menu')
end
