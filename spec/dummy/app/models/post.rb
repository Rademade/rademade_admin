# -*- encoding : utf-8 -*-
class Post
  include Mongoid::Document
  include Sortable

  belongs_to :user
  has_and_belongs_to_many :tags

  field :headline, :type => String
  field :text, :type => String

  def to_s
    headline
  end

end
