# -*- encoding : utf-8 -*-
class Post
  include Mongoid::Document
  include Sortable

  belongs_to :user
  has_and_belongs_to_many :tags

  mount_uploader :avatar, PosterUploader
  mount_uploader :document, FileUploader
  mount_uploader :video, VideoUploader

  field :headline, :type => String
  field :text, :type => String
  field :status, :type => Integer

  validates_presence_of :headline

  def to_s
    headline
  end

end
