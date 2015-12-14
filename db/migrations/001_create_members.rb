Sequel.migration do
  change do
    create_table(:members) do
      primary_key :id
      column :first_name, :varchar
      column :last_name, :varchar
      column :email, :varchar
      column :active, :boolean, default: true
    end
  end
end
