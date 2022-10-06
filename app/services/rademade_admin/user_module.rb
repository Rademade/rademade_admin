# -*- encoding : utf-8 -*-
#todo move to concern/model dir
module RademadeAdmin
  module UserModule

    def self.get_by_email(email)
      raise NotImplementedError.new "Implement 'get_by_email' method"
    end

    def method_missing(name, *arguments)
      if %w(id email password valid_password? admin?).include? name
        raise NotImplementedError.new "Implement '#{name}' method"
      end
      super
    end

  end
end
