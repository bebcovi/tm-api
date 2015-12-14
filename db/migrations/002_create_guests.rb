Sequel.migration do
  change do
    create_table(:guests) do
      primary_key :id
      column :first_name, :varchar
      column :last_name, :varchar
      column :email, :varchar
    end
  end
end
