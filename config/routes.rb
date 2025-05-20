Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "public/homes#top"
  get '/about' => 'public/homes#about', as: 'about'

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update] 
    resources :customers, only: [:index, :show, :edit, :update] 
    resources :orders, only: [:show, :update] 
    resources :order_details, only: [:update] 
    get '/' => 'homes#top'
  end

  scope module: :public do
    get '/customers/mypage' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    patch '/customers/information' => 'customers#update'
    get '/customers/check' => 'customers#check'
    patch '/customers/withdraw' => 'customers#withdraw'

    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'

    post '/orders/check' => 'orders#check'
    get '/orders/confirm' => 'orders#confirm'

    get '/search' => 'items#search'

    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :orders, only: [:new, :create, :index, :show] 
    resources :addresses, only: [:index, :edit, :create, :update, :destroy] 
    resources :genres, only: [:show]
  end
  
end
