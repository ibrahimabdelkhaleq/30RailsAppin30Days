Rails.application.routes.draw do
  resources :orders,only: [:index] #/orders
  resources :tables, except: [:new, :edit] do
   resources :orders,only: [:create] do #/tables/:id/orders
    post :add, on: :member
    post :pay, on: :member
   end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   end
  end