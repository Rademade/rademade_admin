class ActiveGalleryPhoto < ActiveRecord::Base

  belongs_to :active_gallery

  mount_uploader :image, PosterUploader

end
