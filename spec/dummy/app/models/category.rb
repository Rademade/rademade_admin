class Category < Sequel::Model

  one_to_many :items

  def to_s
    name
  end

end