class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string	:name
      t.integer	:count
      t.references :company , index: :true
      t.timestamps null: false
    end
  end
end
