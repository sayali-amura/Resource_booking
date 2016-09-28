class AddCompanyIdToBookings < ActiveRecord::Migration
  def change
  	add_column :bookings, :company_id , :integer, index: true
  end
end
