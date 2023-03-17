Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index'
    resources :admins
    resources :subjects
    resources :questions
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'site/welcome#index'
end