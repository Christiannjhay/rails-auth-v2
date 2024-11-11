Rails.application.routes.draw do
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  

  resources :users
  
  resources :hotels do
    resources :rooms, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  
  get 'home', to: 'home#index'
  get 'login', to: 'sessions#new'

  get 'admin/login', to: 'admin_session#new', as: 'admin_login'
  get 'admin/home', to: 'admin_home#new', as: 'admin_home_view'
  post 'admin/login', to: 'admin_session#create', as: 'admin_login_post'

  get 'admin/hotel', to: 'hotels#new', as: 'create_hotel_view'
  post 'admin/hotel', to: 'hotels#create'
  
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout' 

end
