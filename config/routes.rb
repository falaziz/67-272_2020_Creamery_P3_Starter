Rails.application.routes.draw do

  get 'assignments/new'
  get 'assignments/show'
  get 'assignments/index'
  get 'assignments/terminate'
  get 'assignments/create'
  get 'stores/new'
  get 'stores/show'
  get 'stores/index'
  get 'stores/edit'
  get 'stores/update'
  get 'employees/new'
  get 'employees/show'
  get 'employees/index'
  get 'employees/edit'
  get 'employees/update'
  # Your routes go here
  resources :employee
  resources :store
  resources :assignment
  
  root to: "employees#index", as: :home


end
