class ChangeDurationToBookings < ActiveRecord::Migration
  def change
  	remove_column :bookings, :duration
    add_column :bookings, :duration, :float

  end
end
