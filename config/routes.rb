# -*- encoding : utf-8 -*-
RademadeAdmin::Engine.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root 'dashboard#index'

  #todo via resources :file
  match 'file-upload' => 'file#upload', :via => [:post, :patch]
  match 'file-download/:model/:id/:uploader/:column' => 'file#download', :via => [:get]
  match 'file-crop' => 'file#crop', :via => [:post, :patch]

  match 'status/:model/:id' => 'status#toggle', :via => [:post, :patch]

  post 'sessions' => 'sessions#login'
  get 'login' => 'dashboard#login', :as => :login

  resource :forgot_passwords, only: [:show, :create]
  resources :reset_passwords, only: [:show, :update], :constraints => { :id => /.*/ }

  resources :sessions do
    get 'logout', :on => :collection
  end

end
