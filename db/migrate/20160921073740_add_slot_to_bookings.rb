class AddSlotToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :slot, :integer
  end
end
