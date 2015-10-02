# -*- encoding : utf-8 -*-
Rails.application.routes.draw do

  mount RademadeAdmin::Engine => '/'
  namespace :rademade_admin, path: '/' do

    # Mongoid
    admin_resources :users, :posts, :tags
    # Active record
    admin_resources :authors, :articles, :rubrics
    # Sequel
    admin_resources :categories, :items, :colors

  end

end