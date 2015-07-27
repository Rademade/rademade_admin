class TranslateAuthors < ActiveRecord::Migration

  def self.up
    Author.create_translation_table!({
      :file => :string
    }, {
      :migrate_data => true
    })
    remove_column :authors, :file
  end

  def self.down
    Author.drop_translation_table! :migrate_data => true
    add_column :authors, :file, :string
  end

end