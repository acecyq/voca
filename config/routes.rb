Rails.application.routes.draw do
  # devise_for :views
  devise_for :users
  devise_scope :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'orders#index'
end
