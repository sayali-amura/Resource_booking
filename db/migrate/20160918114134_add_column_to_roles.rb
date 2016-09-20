class AddColumnToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :designation, :string
    add_column :roles, :department, :string
    add_column :roles, :priority, :integer
    add_reference :roles, :company, index: :true, null: :false
    add_foreign_key :roles, :companies
  end
end
