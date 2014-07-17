# -*- encoding : utf-8 -*-
FactoryGirl.define do

  factory :simple_user, class: User do
    first_name 'John'
    last_name 'Doe'
    email 'simple@user.com'
    password '12345678'
    admin false
  end

  factory :admin_user, class: User do
    first_name 'Admin'
    last_name 'User'
    email 'admin@user.com'
    password '12345678'
    admin true
  end

end
