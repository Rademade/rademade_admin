# -*- encoding : utf-8 -*-
RademadeAdmin::Engine.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root 'dashboard#index'

  #todo via resources :file
  match 'file-upload' => 'file#upload', :via => [:post, :patch]
  match 'file-download/:model/:id/:uploader/:column' => 'file#download', :via => [:get]
  match 'file-crop' => 'file#crop', :via => [:post, :patch]

  #todo via resources :gallery
  match 'gallery-upload' => 'gallery#upload', :via => [:post, :patch]
  match 'gallery-crop' => 'gallery#crop', :via => [:post, :patch]
  match 'gallery-sort' => 'gallery#sort', :via => [:post, :patch]
  match 'gallery-remove/:id' => 'gallery#remove', :via => [:delete]

  match 'status/:model/:id' => 'status#toggle', :via => [:post, :patch]

  post 'sessions' => 'sessions#login'
  get 'login' => 'dashboard#login', :as => :login

  resources :sessions do
    get 'logout', :on => :collection
  end

end
