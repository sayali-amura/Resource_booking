class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.string :comment
      t.integer :status
      t.integer :resource_id
      t.refernces :employee, index: :true 
      t.timestamps null: false
    end
  end
end
