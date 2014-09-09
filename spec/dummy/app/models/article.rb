class Article < ActiveRecord::Base

  belongs_to :author

  translates :name

  def to_s
    name
  end

end
