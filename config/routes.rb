Rails.application.routes.draw do
  get 'orders/index'
  root 'products#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :products do
    member do
      get 'buynow'
      get 'addcart'
    end
    # resources :carts
  end

  resources :carts do
    get 'confirm_order'
    post 'confirm_order'

    collection do
      get 'checkout'
    end
  end
  resources :cart_items do
  end
  resources :orders do

    member do
      get 'cancel'
      get 'confirm_del'
    end
    collection do
      get 'delivery_confirm'
      get 'order_history'
    end
  end
  resources :order_items do
  end
end
