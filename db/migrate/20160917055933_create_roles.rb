class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :designation 
      t.string :department
      t.integer :priority
      t.references :company, index: :true ,null: :false
      t.timestamps null: false
    end
  end
end
