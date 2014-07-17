# -*- encoding : utf-8 -*-
#todo move to concern/model dir
module RademadeAdmin
  module UserModule

    def self.included(base)
      base.class_eval do
        devise :database_authenticatable
      end
    end

    def password
      raise NotImplementedError.new 'Implement "password" method'
    end

  end
end
