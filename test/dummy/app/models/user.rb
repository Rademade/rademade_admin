class User < RademadeAdmin::AdminUser
  field :status, :type => String
  has_many :posts
end