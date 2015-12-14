Sequel.migration do
  change do
    create_table(:participations) do
      primary_key :id
      foreign_key :meeting_id, :meetings
      foreign_key :member_id, :members
      foreign_key :guest_id, :guests

      column :role, :varchar
      column :role_data, :jsonb
    end
  end
end
