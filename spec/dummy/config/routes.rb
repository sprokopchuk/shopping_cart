Rails.application.routes.draw do

  root "home#index"
  mount ShoppingCart::Engine => "/shopping_cart"
  devise_for :users,  path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', registration: 'settings', sign_up: 'register' }
end
