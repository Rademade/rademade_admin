class Rubric < ActiveRecord::Base

  has_many :author_rubrics, :dependent => :destroy
  has_many :authors, :through => :author_rubrics

  validates_uniqueness_of :name

  def to_s
    name
  end

end
