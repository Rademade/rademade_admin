rademade_admin
========

[![Gem Version](http://img.shields.io/gem/v/rademade_admin.svg)][gem]
[![Build Status](https://travis-ci.org/Rademade/rademade_admin.svg?branch=master)][travis-ci]
[![Coverage Status](https://coveralls.io/repos/Rademade/rademade_admin/badge.png)][coveralls]
[![Code Climate](http://img.shields.io/codeclimate/github/Rademade/rademade_admin.svg)][codeclimate]
[![PullReview stats](https://www.pullreview.com/github/Rademade/rademade_admin/badges/master.svg?)][pullreview]


[gem]: https://rubygems.org/gems/rademade_admin
[travis-ci]: https://travis-ci.org/Rademade/rademade_admin
[coveralls]: https://coveralls.io/r/Rademade/rademade_admin
[codeclimate]: https://codeclimate.com/github/Rademade/rademade_admin
[pullreview]: https://www.pullreview.com/github/Rademade/rademade_admin/reviews/master

**Best rails admin panel!**


How to use it
--------------

1) Add `gem 'rademade_admin', :github => 'rademade/rademade_admin'` to Gemfile

2) Update `config/initializers/assets.rb` with line:
```ruby
config.assets.precompile += %w( rademade_admin.css rademade_admin.js)
```

3) Mount rails engine at routing.rb `mount RademadeAdmin::Engine => '/rademade_admin`

4) Create `User` model  and other needed models
```ruby
# encoding: utf-8
require 'digest/sha1'

class User
  include Mongoid::Document
  include RademadeAdmin::UserModule

  field :first_name, :type => String
  field :email, :type => String
  field :encrypted_password, :type => String
  field :admin, :type => Boolean, :default => false

  def self.get_by_email(email)
    self.where(:email => email).first
  end

  def password=(password)
    self[:encrypted_password] = encrypt_password(password) unless password.blank?
  end

  def valid_password?(password)
    self[:encrypted_password] == encrypt_password(password)
  end

  def to_s
    email
  end

  private

  def encrypt_password(password)
    Digest::SHA1.hexdigest(password)
  end

end
```


5) Add rademade_admin initializer `initializers/rademade_admin.rb`
```ruby
RademadeAdmin::Configuration.configure do
  admin_model User
end
```

6) Create admin controller. Example `app/controllers/rademade_admin/users_controller.rb`
```ruby
class RademadeAdmin::UsersController < RademadeAdmin::ModelController

  #You can leave controller absolutely empty!
  
  options do
    list do
      email
    end
    form do
      first_name
      email
      password :hint => 'Or leave it empty'
    end
  end

end
```

7) Add `admin_resources` to `routers.rb`
```ruby
namespace :rademade_admin, :path => 'admin' do
  admin_resources :users
end
```

8) Install assets with bower `rake rademade_admin:bower:install`

9) Start rails `rails s`

**Good luck :)**


Supported options
--------------
```ruby
options do
  model 'ModelName'
  
  # Navigation menu settings
  parent_menu 'ModelName'
  remove_from_menu 
  
  # Setting for list data (index action)
  # list :attr, :attr_other
  list do
    
  end
  
  # Settings for form
  # form :attr, :attr_other
  form do
    attr :boolean #Other :text, :file, :editor
  end
  
  labels do
    attr 'Label for attribute'
  end
  
end
```
