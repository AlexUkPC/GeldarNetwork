Rails.application.routes.draw do
  authenticate :user do
    resources :timelines,
      only: [:index, :show],
      param: :username
    resources :posts, only: [:create, :show]
  end
  devise_for :users
  get 'home/index'
  root to: 'home#index'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
