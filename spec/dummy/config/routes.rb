# -*- encoding : utf-8 -*-
Rails.application.routes.draw do

  mount RademadeAdmin::Engine => '/'
  namespace :rademade_admin, path: '/' do

    # Mongoid
    admin_resources :users, :posts, :tags
    admin_resources :galleries, :gallery_photos, :only => []

    # Active record
    admin_resources :authors, :articles, :rubrics
    admin_resources :active_galleries, :active_gallery_photos, :only => []

    # Sequel
    admin_resources :categories, :items, :colors
    admin_resources :sequel_galleries, :sequel_gallery_photos, :only => []

  end

end