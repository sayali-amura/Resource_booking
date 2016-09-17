class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.timestamps   :date_of_joining
      t.integer :manager_id
      t.references :role ,index: :true
      t.timestamps null: false
    end
  end
end
