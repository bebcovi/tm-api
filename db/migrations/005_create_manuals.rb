Sequel.migration do
  change do
    create_table(:manuals) do
      primary_key :id
      column :name, :varchar
    end
  end
end
