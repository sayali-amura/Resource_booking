class AddTimingToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :start_time, :float
    add_column :companies, :end_time, :float
  end
end
