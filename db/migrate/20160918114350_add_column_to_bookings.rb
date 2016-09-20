class AddColumnToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :duration, :timestamp
    add_column :bookings, :status, :integer
    add_column :bookings, :priority, :integer
    add_column :bookings, :feedback, :string
    add_column :bookings, :comment, :string
    add_column :bookings, :shift, :integer
    add_reference :bookings, :employee, index: :true, null: :false
    add_foreign_key :bookings, :employees
  end
end
