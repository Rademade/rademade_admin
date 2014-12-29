class CreateActiveGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :active_gallery_photos do |t|
      t.references :active_gallery, index: true
      t.string :image

      t.timestamps
    end
  end
end
