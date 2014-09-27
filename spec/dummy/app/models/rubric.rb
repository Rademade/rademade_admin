class Rubric < ActiveRecord::Base

  has_and_belongs_to_many :authors

  def to_s
    name
  end

end
