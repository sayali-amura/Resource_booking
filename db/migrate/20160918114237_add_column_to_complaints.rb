class AddColumnToComplaints < ActiveRecord::Migration
  def change
    add_column :complaints, :comment, :string
    add_column :complaints, :status, :integer
    add_column :complaints, :resource_id, :integer
    add_reference :complaints, :employee, index: :true, null: :false
    add_foreign_key :complaints, :employees
  end
end
