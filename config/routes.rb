Rails.application.routes.draw do
  root to: 'tasks#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :tasks
     resources :users, only: [:create]
end
