class AddGalleryToArticle < ActiveRecord::Migration

  def change
    add_reference :articles, :active_gallery, index: true
  end

end
