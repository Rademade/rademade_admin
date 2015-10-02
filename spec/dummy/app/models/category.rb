class Category < Sequel::Model

  one_to_many :items

  mount_uploader :image, PosterUploader

  def to_s
    name
  end

end