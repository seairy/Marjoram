# -*- encoding : utf-8 -*-
Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'frontend/home#index'
  scope module: :frontend do
    get 'intro', to: 'contents#intro', as: :intro
    resources :posts
    resources :users do
      collection do
        get :dashboard
        get :edit_password
        post :update_password
        get :edit_project
        put :update_project
        get :show_project
      end
    end
    get 'user_signup' => 'users#new', as: :user_signup
    post 'user_signup' => 'users#create'
    get 'user_signin' => 'sessions#new_user', as: :user_signin
    post 'user_signin' => 'sessions#create_user'
    get 'user_signout' => 'sessions#destroy_user', as: :user_signout
  end
  namespace :cms do
    root 'dashboard#index'
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :posts
    resources :users
    resources :excels do
      collection do
        get :all
      end
    end
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