# -*- encoding : utf-8 -*-
RademadeAdmin::Engine.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root 'dashboard#index'

  match 'file-upload' => 'file#upload', :via => [:post, :patch]
  match 'gallery-upload' => 'gallery#upload', :via => [:post, :patch]
  match 'gallery-sort' => 'gallery#sort', :via => [:post, :patch]
  match 'gallery-remove/:id' => 'gallery#remove', :via => [:delete]
  match 'file-crop' => 'file#crop', :via => [:post, :patch]

  post 'sessions' => 'sessions#login'
  get 'login' => 'dashboard#login', :as => 'login'

  resources :sessions do
    get 'logout', :on => :collection
  end

end
