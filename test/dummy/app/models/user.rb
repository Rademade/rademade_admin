class User
  include RademadeAdmin::UserModule

  field :status, :type => String
  has_many :posts

end