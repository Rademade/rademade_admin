Sequel.migration do
  change do
    create_table(:colors_items) do
      foreign_key :color_id, :colors
      foreign_key :item_id, :items
      index [:color_id, :item_id], :unique => true
    end
  end
end