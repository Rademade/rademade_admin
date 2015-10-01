class Color < Sequel::Model

  many_to_many :items

  def to_s
    name
  end

end