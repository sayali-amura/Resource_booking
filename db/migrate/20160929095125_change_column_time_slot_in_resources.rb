class ChangeColumnTimeSlotInResources < ActiveRecord::Migration
  def change
  	remove_column :resources, :time_slot
  	add_column :resources, :time_slot, :time
#  	change_column :resources, :time_slot, :time
  end
end
