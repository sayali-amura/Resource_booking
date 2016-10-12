class RemoveUniqueEmailFromEmployee < ActiveRecord::Migration
  def change
  	remove_column :employees, :email, :string, unique: true
  	add_column :employees, :email, :string
  end
end
