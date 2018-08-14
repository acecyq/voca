Rails.application.routes.draw do
  # devise_for :views
  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '/orders/home', to: 'orders#home', as: 'home_orders'
  get '/orders/:id/sms', to: 'orders#sms', as: 'sms_order'
  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'orders#index'
end
