class ReplaceAuthorRubrics < ActiveRecord::Migration

  def self.up
    drop_table :author_rubrics
    create_table :author_rubrics do |t|
      t.column :author_id, :integer, :null => false
      t.column :rubric_id, :integer, :null => false
      t.column :position, :integer
    end
  end

  def self.down

  end

end