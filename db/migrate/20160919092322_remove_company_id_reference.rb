class RemoveCompanyIdReference < ActiveRecord::Migration
  def change
  	remove_column :resources , :company_id ,index: true
  	remove_column :roles, :company_id , index: true
  end
end
