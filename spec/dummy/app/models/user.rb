# -*- encoding : utf-8 -*-
class User
  include Mongoid::Document
  include RademadeAdmin::UserModule

  has_many :posts, :dependent => :destroy, :sortable => true

  field :first_name, :type => String
  field :last_name, :type => String
  field :email, :type => String
  field :encrypted_password, :type => String
  field :admin, :type => Boolean, :default => false
  field :status, :type => String

  mount_uploader :avatar, PosterUploader, :localize => true

  def self.get_by_email(email)
    self.where(:email => email).first
  end

  def password=(password)
    self[:encrypted_password] = password unless password.empty?
  end

  def password
    self[:encrypted_password]
  end

  def valid_password?(password)
    self[:encrypted_password] == password
  end

  def to_s
    "#{first_name} #{last_name}"
  end

end
