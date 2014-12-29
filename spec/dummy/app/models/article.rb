class Article < ActiveRecord::Base

  belongs_to :active_gallery
  belongs_to :author

  translates :name

  def to_s
    name
  end

end
