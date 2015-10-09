Sequel.migration do
  change do
    add_column :categories, :image, String
  end
end