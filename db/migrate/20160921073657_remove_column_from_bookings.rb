class RemoveColumnFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :duration, :float
    remove_column :bookings, :shift, :boolean
  end
end
