module RademadeAdmin
  module UserModule
    extend ActiveSupport::Concern

    included do
      include Mongoid::Document

      devise :database_authenticatable, :validatable

      field :first_name, :type => String
      field :last_name, :type => String
      field :email, :type => String
      field :encrypted_password, :type => String
      field :admin, :type => Boolean, :default => true

      validates_uniqueness_of :email

    end

    def password=(password)
      self[:password] = password
      super(password) unless password.blank?
    end

    def password
      self[:encrypted_password]
    end

    def to_s
      "#{first_name} #{last_name}"
    end

  end
end
