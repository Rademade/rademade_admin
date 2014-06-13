class Post
  include Mongoid::Document
  include RademadeAdmin::Sortable

  belongs_to :user

  field :headline, :type => String
  field :text, :type => String
end