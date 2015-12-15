Sequel.migration do
  change do
    create_table(:speeches) do
      primary_key :id
      foreign_key :manual_id, :manuals
      column :title, :varchar
      column :number, :integer
    end
  end
end
