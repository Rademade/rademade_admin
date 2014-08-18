class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :photo
      t.boolean :verified

      t.timestamps
    end
  end
end
