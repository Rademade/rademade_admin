class Gallery
  include Mongoid::Document
  include RademadeAdmin::Gallery

  has_many :images, :class_name => 'GalleryPhoto', :autosave => true, :dependent => :destroy

end