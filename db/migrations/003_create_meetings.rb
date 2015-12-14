Sequel.migration do
  change do
    create_table(:meetings) do
      primary_key :id
      column :date, :date
      column :note, :text
    end
  end
end
