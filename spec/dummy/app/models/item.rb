class Item < Sequel::Model
  include RademadeAdmin::Hideable
  
  many_to_one :category

  def to_s
    name
  end

end