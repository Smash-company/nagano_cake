Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "public/homes#top"
  get '/about' => 'public/homes#about', as: 'about'

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :show, :edit, :update] 
    resources :customers, only: [:index, :show, :edit, :update] 
    resources :orders, only: [:show, :update] 
    resources :order_details, only: [:update] 
    root to: 'homes#top'
  end

  scope module: :public do
    resources :items, only: [:index, :show]

    get '/customers/mypage' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    patch '/customers/information' => 'customers#update'
    get '/customers/check' => 'customers#check'
    patch '/customers/withdraw' => 'customers#withdraw'

    get '/cart_items' => 'cart_items#index'
    patch '/cart_items/:id' => 'cart_items#update'
    delete '/cart_items/:id' => 'cart_items#destroy'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    post '/cart_items' => 'cart_items#create'

    resources :orders, only: [:new, :check, :confirm, :create, :index, :show] 
    resources :addresses, only: [:index, :edit, :create, :update, :destroy] 
  end
  
end
