class AddDateOfBookingtoBookings < ActiveRecord::Migration
  def change
  	add_column :bookings , :date_of_booking, :date
  	change_column :bookings, :duration, :time
  end
end
