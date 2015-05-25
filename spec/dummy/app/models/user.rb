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
  field :address_lat, :type => Float
  field :address_lng, :type => Float
  field :address_zoom, :type => Integer

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

  def address
    {
      :latitude => address_lat,
      :longitude => address_lng,
      :zoom => address_zoom
    }
  end

  def address=(location)
    self.address_lat = location['latitude']
    self.address_lng = location['longitude']
    self.address_zoom = location['zoom']
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin_text
    admin? ? 'Администратор' : 'Пользователь'
  end

  def to_s
    full_name
  end

end
