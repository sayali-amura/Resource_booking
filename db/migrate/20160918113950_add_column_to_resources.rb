class AddColumnToResources < ActiveRecord::Migration
  def change
    add_column :resources, :name, :string
    add_column :resources, :count, :integer
    add_reference :resources, :company, index: :true, null: :false
    add_foreign_key :resources, :companies
  end
end
