class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :birthday, :date
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :zip, :integer
  end
end
