class AddCompanyIdToTables < ActiveRecord::Migration
  def change
    add_column :roles, :company_id, :integer, index: true
    add_column :employees, :company_id, :integer, index: true
    add_column :resources, :company_id, :integer, index: true
  end
end
