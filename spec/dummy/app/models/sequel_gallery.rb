class SequelGallery < Sequel::Model
  include RademadeAdmin::Gallery

  one_to_many :images, :class => SequelGalleryPhoto

end