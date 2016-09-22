class AddUniquenessToCompanies < ActiveRecord::Migration
  def change
  	remove_index :companies,:phone if index_exists?(:companies, :phone, unique: true)
  	remove_index :companies,:email if index_exists?(:companies, :email, unique: true)	
  	add_index :companies,:email, unique: true
  	add_index :companies,:phone, unique: true
  end
end
