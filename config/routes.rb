Rails.application.routes.draw do
  get '/static_pages/contact', to: 'static_pages#contact'

  get '/static_pages/team', to: 'static_pages#team'

  get 'welcome/:user_entry', to: 'welcome#show'

  resources :gossips

  resources :users, only: [:show, :new, :create]

  resources :city, only: [:show]

  resources :gossips do
    resources :comments
  end

  resources :sessions, only: [:new, :create, :destroy]

end
