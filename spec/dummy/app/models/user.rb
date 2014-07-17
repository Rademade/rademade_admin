# -*- encoding : utf-8 -*-
class User
  include Mongoid::Document
  include RademadeAdmin::UserModule

  has_many :posts

  field :first_name, :type => String
  field :last_name, :type => String
  field :email, :type => String
  field :encrypted_password, :type => String
  field :admin, :type => Boolean, :default => false
  field :status, :type => String

  def password=(password)
    super(password) unless password.blank?
  end

  def password
    self[:encrypted_password]
  end

  def to_s
    "#{first_name} #{last_name}"
  end

end
