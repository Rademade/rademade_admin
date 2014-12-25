class Gallery
  include Mongoid::Document
  include RademadeAdmin::Gallery

  has_many :images, :class_name => 'GalleryPhoto', :sortable => true, :dependent => :destroy

end