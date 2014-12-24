class Gallery
  include Mongoid::Document

  has_many :images, :class_name => 'GalleryPhoto', :autosave => true, :dependent => :destroy

end