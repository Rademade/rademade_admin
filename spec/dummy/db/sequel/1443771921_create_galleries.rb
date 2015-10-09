Sequel.migration do
  change do
    create_table(:sequel_galleries) do
      primary_key :id
    end
  end
end