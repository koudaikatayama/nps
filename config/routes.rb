Rails.application.routes.draw do

  namespace :admin do
    get 'tags/index'
    get 'tags/edit'
  end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: "homes#top"
    get "homes/about"=>"homes#about", as: "about"
    
    resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    
    get "users/mypage/:id" => "users#show", as: "users_mypage"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
    get "/users/check" => "users#check"
    patch "/users/withdraw" => "users#withdraw"
    
    resources :users do
      member do
        get :likes
      end
    end
    get "search" => "posts#search"
  end
  
  namespace :admin do
    get "/" => "homes#top"
    
    resources :genres, only: [:index, :create, :edit, :update,]
    resources :genres do
      member do
        delete :destroy
      end
    end
    
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
     resources :comments, only: [:create, :destroy]
    
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
