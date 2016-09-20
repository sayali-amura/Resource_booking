class RemoveForeignkeys < ActiveRecord::Migration
  def change
  	remove_foreign_key :messages, :bookings
  	remove_foreign_key :bookings, :employees
  	remove_foreign_key :complaints, :employees
  	remove_foreign_key :roles, :companies
  	remove_foreign_key :employees, :roles
  	remove_foreign_key :resources, :companies
  end
end
