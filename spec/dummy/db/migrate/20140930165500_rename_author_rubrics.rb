class RenameAuthorRubrics < ActiveRecord::Migration

  def self.up
    rename_table :authors_rubrics, :author_rubrics
  end

  def self.down
    rename_table :author_rubrics, :authors_rubrics
  end

end