Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "public/homes#top"

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :show, :edit, :update] 
    resources :customers, only: [:index, :show, :edit, :update] 
    resources :orders, only: [:show, :update] 
    resources :order_details, only: [:update] 
    get 'homes/top'
  end

  namespace :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :check, :withdraw] 
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create] 
    resources :orders, only: [:new, :check, :confirm, :create, :index, :show] 
    resources :addresses, only: [:index, :edit, :create, :update, :destroy] 
  end
  
end
