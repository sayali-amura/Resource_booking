class CreateCompanies < ActiveRecord::Migration
  def change
  	drop_table 'companies' if ActiveRecord::Base.connection.table_exists? 'companies'
    create_table :companies do |t|
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
