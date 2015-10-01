class Item < Sequel::Model
  include RademadeAdmin::Hideable
  
  many_to_one :category
  many_to_many :items

  def to_s
    name
  end

end