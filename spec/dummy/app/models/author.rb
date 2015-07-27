class Author < ActiveRecord::Base

  has_many :articles, :sortable => true, :sortable_field => :author_position
  has_many :author_rubrics, :dependent => :destroy
  has_many :rubrics, :through => :author_rubrics, :sortable => true

  translates :file

  accepts_nested_attributes_for :translations

  Translation.mount_uploader :file, PosterUploader

  def to_s
    name
  end

end
