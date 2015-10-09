Sequel.migration do
  change do
    alter_table(:items) do
      add_foreign_key :sequel_gallery_id, :sequel_galleries
    end
  end
end