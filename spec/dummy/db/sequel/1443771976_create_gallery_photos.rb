Sequel.migration do
  change do
    create_table(:sequel_gallery_photos) do
      primary_key :id
      foreign_key :sequel_gallery_id, :sequel_galleries
      String :image
    end
  end
end