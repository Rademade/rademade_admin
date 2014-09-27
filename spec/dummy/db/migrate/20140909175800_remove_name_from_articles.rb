class RemoveNameFromArticles < ActiveRecord::Migration

  def self.up
    remove_column :articles, :name
  end

  def self.down
    add_column :articles, :name, :string
  end

end