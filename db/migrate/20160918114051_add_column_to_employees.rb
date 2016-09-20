class AddColumnToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :name, :string
    add_column :employees, :email, :string
    add_column :employees, :password_digest, :string
    add_column :employees, :date_of_joining, :date
    add_column :employees, :manager_id, :integer
    add_reference :employees, :role, index: :true, null: :false
    add_foreign_key :employees, :roles
  end
end
