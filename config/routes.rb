Rails.application.routes.draw do
  get 'menu', to: 'static_pages#menu'
  get 'queue', to: 'static_pages#queue'
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
