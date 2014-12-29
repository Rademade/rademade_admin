# -*- encoding : utf-8 -*-
Rails.application.routes.draw do

  mount RademadeAdmin::Engine => '/rademade_admin'
  namespace :rademade_admin do

    admin_resources :users, :posts, :tags
    admin_resources :authors, :articles, :rubrics
    admin_resources :galleries, :active_galleries, :only => []

  end

end
