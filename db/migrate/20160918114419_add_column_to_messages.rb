class AddColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :content, :string
    add_reference :messages,:booking,index: :true, null: :false
    add_foreign_key :messages, :bookings
  end
end
