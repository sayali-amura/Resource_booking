class AddColumnsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :property_id, :integer, index: true
    add_column :messages, :property_type, :string, index: true
  end
end
