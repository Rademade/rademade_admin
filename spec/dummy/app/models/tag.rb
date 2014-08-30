# -*- encoding : utf-8 -*-
class Tag
  include Mongoid::Document

  field :name, :type => String, :localize => true
  has_and_belongs_to_many :posts

  def to_s
    name
  end

end
