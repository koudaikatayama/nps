Rails.application.routes.draw do
  
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
    
    resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    
    get "users/mypage" => "users#show"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
    get "/users/check" => "users#check"
    patch "/users/withdraw" => "usres#withdraw"
  end
  
  namespace :admin do
    get "/" => "homes#top"
    
    resources :genres, only: [:index, :create, :edit, :update]
    
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
