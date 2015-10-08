Sequel.migration do
  change do
    create_table(:items) do
      primary_key :id
      foreign_key :category_id, :categories
      String :name, :null => false
      Float :price
      Boolean :status
    end
  end
end