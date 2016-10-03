class RemovePriorityFromBookings < ActiveRecord::Migration
  def change
  	remove_column :bookings, :priority, :integer
  end
end
