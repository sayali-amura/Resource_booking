class AddTimeSlotToResources < ActiveRecord::Migration
  def change
    add_column :resources, :time_slot, :float
  end
end
