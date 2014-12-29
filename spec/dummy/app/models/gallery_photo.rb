class GalleryPhoto
  include Mongoid::Document

  belongs_to :gallery

  mount_uploader :image, PosterUploader

end