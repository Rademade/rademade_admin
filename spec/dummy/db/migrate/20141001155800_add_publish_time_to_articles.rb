class AddPublishTimeToArticles < ActiveRecord::Migration

  def self.up
    add_column :articles, :publish_time, :datetime
  end

  def self.down
    remove_column :articles, :publish_time
  end

end