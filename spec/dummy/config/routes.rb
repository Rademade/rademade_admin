# -*- encoding : utf-8 -*-
Rails.application.routes.draw do

  mount RademadeAdmin::Engine => '/rademade_admin'
  namespace :rademade_admin do

    # Mongoid
    admin_resources :users, :posts, :tags
    admin_resources :galleries, :only => []

    # Active record
    admin_resources :authors, :articles, :rubrics
    admin_resources :active_galleries, :only => []

    # Sequel
    admin_resources :categories, :items

  end

end
