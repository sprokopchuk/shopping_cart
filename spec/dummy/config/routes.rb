Rails.application.routes.draw do
  mount ShoppingCart::Engine => "/"
  root "books#index"
  resources :books, only: [:index, :show], format: false
  devise_for :users,  path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', registration: 'settings', sign_up: 'register' }
end
