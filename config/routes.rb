Rails.application.routes.draw do

  # Your routes go here
  resources :employees
  resources :stores
  resources :assignments
  
  get '/assignments/terminate', to: 'assignments#terminate'
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  
  root to: "employees#index", as: :home


end
