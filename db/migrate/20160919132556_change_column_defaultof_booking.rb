class ChangeColumnDefaultofBooking < ActiveRecord::Migration
  def change
  	change_column :bookings, :status, :boolean
  	change_column_default :bookings, :shift, from: nil, to: false
  	change_column_default :bookings, :status, from: nil, to: 0
  end
end
