class ActiveGallery < ActiveRecord::Base
  include RademadeAdmin::Gallery

  has_many :images, :class_name => 'ActiveGalleryPhoto', :dependent => :destroy

end