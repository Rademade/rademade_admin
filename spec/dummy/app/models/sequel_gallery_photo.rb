class SequelGalleryPhoto < Sequel::Model

  many_to_one :sequel_gallery

  mount_uploader :image, PosterUploader

end