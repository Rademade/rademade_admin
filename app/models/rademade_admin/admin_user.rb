module RademadeAdmin
  class AdminUser
    include Mongoid::Document
    include RademadeAdmin::Sortable

    devise :database_authenticatable, :validatable

    field :first_name, :type => String
    field :last_name, :type => String
    field :email, :type => String

    field :password
    field :encrypted_password, :type => String

    field :admin, :type => Boolean, :default => true

    validates_length_of :password, :minimum => 6, :too_short => 'Минимальная длина пароля 6 символов'

    def password=(password)
      self[:password] = password
      super(password) unless password.blank?
    end

    def password
      self[:encrypted_password]
    end

    def to_s
      "#{name} #{last_name}"
    end
  end
end
