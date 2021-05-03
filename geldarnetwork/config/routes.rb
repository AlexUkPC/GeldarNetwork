Rails.application.routes.draw do
  
  authenticate :user do
    resources :timelines,
      only: [:index, :show],
      param: :username
    resources :posts, only: [:create, :show, :destroy]
    resources :bonds, param: :username do
      member do
        post :follow
        post :unfollow
        post :accept
        post :reject
        get :followers
        get :following
      end
    end
    namespace :settings do
      resource :user, only: [:show, :update]
    end
    namespace :api do
      namespace :v1 do
        resources :places, only: [:index]
      end
    end
  end
  devise_for :users
  root to: 'home#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
