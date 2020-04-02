Rails.application.routes.draw do

  # Your routes go here
  resources :employees
  resources :stores
  resources :assignments
  
  get '/assignments/terminate', to: 'assignments#terminate'
  
  root to: "employees#index", as: :home


end
