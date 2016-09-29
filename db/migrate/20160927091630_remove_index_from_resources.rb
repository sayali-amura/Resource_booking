class RemoveIndexFromResources < ActiveRecord::Migration
  def change
  	remove_index(:resources, [:name])
  end
end
