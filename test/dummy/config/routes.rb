Rails.application.routes.draw do

  mount RademadeAdmin::Engine => "/rademade_admin"

  #admin_resources :post
end
