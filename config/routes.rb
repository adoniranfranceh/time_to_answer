Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  namespace :site do
    get 'welcome/index'
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