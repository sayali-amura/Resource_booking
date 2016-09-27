class AddUniqueIndexToTables < ActiveRecord::Migration
  def change
  	add_index :resources, :name, unique: true
  	remove_index(:resources, [:name])
  end
end
