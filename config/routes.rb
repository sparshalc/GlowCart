Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  resources :pages

  get '/about', from: 'pages#about', to: 'pages#about'
  get '/admin', from: 'pages#admin', to: 'pages#admin'
  get '/admin/product', from: 'pages#product', to: 'pages#product'

  resources :products do
    resources :comments
  end

  get 'cart', to: 'cart#show'
  get 'cart/update_lcd'
  post 'cart/add'
  post 'cart/destroy'

end