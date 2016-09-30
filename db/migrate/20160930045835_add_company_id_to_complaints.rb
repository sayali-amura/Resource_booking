class AddCompanyIdToComplaints < ActiveRecord::Migration
  def change
  	add_column :complaints, :company_id, :integer, index: true
  end
end
