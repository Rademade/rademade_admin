class Rubric < ActiveRecord::Base

  has_many :author_rubrics, :dependent => :destroy
  has_many :authors, :through => :author_rubrics

  def to_s
    name
  end

end
