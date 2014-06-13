RademadeAdmin::Engine.routes.draw do

  # todo: user_class global RademadeAdmin method
  # now we use default admin user
  devise_for :users, class_name: RademadeAdmin.user_class, module: :devise
  root 'dashboard#index'

  get 'login' => 'dashboard#login', :as => 'login'

  resources :sessions do
    delete 'logout', :on => :collection
  end

  admin_resources :admin_users
end
