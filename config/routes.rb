Rails.application.routes.draw do
  root 'static_pages#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  # resources :users
  resources :users do
    resources :microposts, only: [:create, :destroy]
    # post 'microposts', to: 'microposts#create'
    # delete 'microposts/:id', to: 'microposts#destroy'
  end
end
