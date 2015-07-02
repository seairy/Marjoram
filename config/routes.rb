# -*- encoding : utf-8 -*-
Rails.application.routes.draw do
  root 'frontend/home#index'
  namespace :cms do
    root 'dashboard#index'
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :administrators
    resource :profile do
      get 'edit_password'
      put 'update_password'
    end
    get 'signin', to: 'sessions#new', as: :signin
    post 'signin', to: 'sessions#create'
    get 'signout', to: 'sessions#destroy', as: :signout
  end
end