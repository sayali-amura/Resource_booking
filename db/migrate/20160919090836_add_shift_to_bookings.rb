class AddShiftToBookings < ActiveRecord::Migration
  def change
    change_column :bookings, :shift, 'boolean USING CAST(shift AS boolean)'
  end
end
