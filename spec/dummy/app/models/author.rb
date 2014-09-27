class Author < ActiveRecord::Base

  has_many :articles
  has_and_belongs_to_many :rubrics, :sortable => true

  translates :photo

  accepts_nested_attributes_for :translations

  Translation.mount_uploader :photo, PosterUploader

  def to_s
    name
  end

end
