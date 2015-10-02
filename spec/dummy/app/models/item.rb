class Item < Sequel::Model
  include RademadeAdmin::Hideable
  
  many_to_one :category
  many_to_one :sequel_gallery
  many_to_many :colors

  def to_s
    name
  end

end