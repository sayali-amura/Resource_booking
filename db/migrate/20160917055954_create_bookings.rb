class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :employee, index: :true, null: :false
      t.timestamps :duration
      t.integer :status
      t.integer :priority
      t.string :feedback
      t.string :comment
      t.integer :shift
      t.timestamps null: false
    end
  end
end
