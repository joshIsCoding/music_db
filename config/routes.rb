Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :new] do
    get 'activate', on: :collection
  end
  resource :session, only: [:create, :new, :destroy]
  
  # assets
  resources :artists do
    resources :albums, only: [:new]
  end
  
  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]
  resources :notes, only: [:create, :destroy]
end
