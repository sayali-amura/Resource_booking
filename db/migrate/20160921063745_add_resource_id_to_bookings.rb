class AddResourceIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :resource_id, :integer,index: true
  end
end
