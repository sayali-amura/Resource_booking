class ChangeColumnDefaultofBooking < ActiveRecord::Migration

  def up 
  	change_column :bookings, :shift, :boolean
  	change_column_default :bookings, :status, 0
  	change_column_default :bookings, :shift, false
  end

  def down
  	change_column :bookings, :shift, :integer
  	change_column :bookings, :status, :integer
  	change_column_default :bookings, :shift, nil
  	change_column_default :bookings, :status, nil
  end
end
