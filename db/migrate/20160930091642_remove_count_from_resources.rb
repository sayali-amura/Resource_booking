class RemoveCountFromResources < ActiveRecord::Migration
  def change
    remove_column :resources, :count, :integer
  end
end
