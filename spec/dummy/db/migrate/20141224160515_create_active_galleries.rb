class CreateActiveGalleries < ActiveRecord::Migration
  def change
    create_table :active_galleries do |t|

      t.timestamps
    end
  end
end
