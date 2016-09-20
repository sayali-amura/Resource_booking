class AddReplyToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :reply, :string
  end
end
