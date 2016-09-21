class RemoveReplyFromBookings < ActiveRecord::Migration
  def change
  	remove_column :bookings, :reply, :string
  end
end
