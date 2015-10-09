class Category < Sequel::Model

  one_to_many :items

  mount_uploader :image, PosterUploader

  plugin :validation_helpers

  def to_s
    name
  end

  def validate
    super
    validates_unique :name
  end

end