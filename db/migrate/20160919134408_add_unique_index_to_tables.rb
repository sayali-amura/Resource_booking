class AddUniqueIndexToTables < ActiveRecord::Migration
  def change
  	add_index :resources, :name, unique: true
  	
  end
end
