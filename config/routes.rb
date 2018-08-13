Rails.application.routes.draw do
  # devise_for :views
  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :orders
  get '/orders/:id/sms', to: 'orders#sms', as: 'sms_order'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'orders#index'
end
