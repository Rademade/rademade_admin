class CreateAuthorsRubrics < ActiveRecord::Migration
  def change
    create_table :authors_rubrics, :id => false do |t|
      t.column :author_id, :integer
      t.column :rubric_id, :integer
      t.column :position, :integer
    end
    add_index :authors_rubrics, [:author_id, :rubric_id], :unique => true
  end
end