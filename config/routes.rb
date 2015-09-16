ShoppingCart::Engine.routes.draw do
  resource :shopping_cart, controller: "cart", only: [:show, :update], format: false
  resource :checkout, controller: "checkout", only: [:update], format: false do
    get 'address'
    get 'delivery'
    get 'payment'
    get 'confirm'
    get 'complete/:id', to: 'checkout#complete', as: :complete
    post "complete/:id", to: 'checkout#complete'
  end
  resources :orders, except: [:destroy, :edit, :update]
  resources :order_items, only: [:create, :destroy] do
    collection do
      post :destroy_all
    end
  end

end
