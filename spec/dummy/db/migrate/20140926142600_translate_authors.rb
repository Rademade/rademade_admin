class TranslateAuthors < ActiveRecord::Migration

  def self.up
    Author.create_translation_table!({
      :photo => :string
    }, {
      :migrate_data => true
    })
    remove_column :authors, :photo
  end

  def self.down
    Author.drop_translation_table! :migrate_data => true
    add_column :authors, :photo, :string
  end

end