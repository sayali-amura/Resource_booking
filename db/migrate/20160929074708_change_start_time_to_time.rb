class ChangeStartTimeToTime < ActiveRecord::Migration
  def change
  	remove_column :companies, :start_time
  	remove_column :companies, :end_time
  	add_column :companies, :start_time, :time
  	add_column :companies, :end_time, :time
  end
end
