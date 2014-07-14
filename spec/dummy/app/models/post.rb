class Post
  include Mongoid::Document
  include Sortable

  belongs_to :user

  field :headline, :type => String
  field :text, :type => String
end