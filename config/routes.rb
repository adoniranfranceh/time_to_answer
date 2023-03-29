Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  devise_for :users

  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  namespace :admins_backoffice do
    get 'welcome/index'
    resources :admins
    resources :subjects
    resources :questions
  end
  get 'backoffice', to: 'admins_backoffice/welcome#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'site/welcome#index'
end
