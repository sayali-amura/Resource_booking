class AddColumnToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :name, :string
    add_column :companies, :address, :string
    add_column :companies, :password_digest, :string
  end
end
