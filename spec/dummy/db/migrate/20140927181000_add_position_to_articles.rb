class AddPositionToArticles < ActiveRecord::Migration

  def self.up
    add_column :articles, :author_position, :integer
  end

  def self.down
    remove_column :articles, :author_position
  end

end