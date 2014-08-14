class Author < ActiveRecord::Base

  has_many :articles

  mount_uploader :photo, PosterUploader

  def to_s
    name
  end

end
