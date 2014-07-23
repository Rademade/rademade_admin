# -*- encoding : utf-8 -*-
Rails.application.routes.draw do

  mount RademadeAdmin::Engine => '/rademade_admin'
  namespace :rademade_admin do
    admin_resources :users
    admin_resources :posts
    admin_resources :tags
  end
end
