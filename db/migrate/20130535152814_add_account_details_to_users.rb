class AddAccountDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :balance, :decimal, precision: 8, scale: 2, null: false, default: 0
    add_column :users, :lat, :string
    add_column :users, :lng, :string
    add_column :users, :address, :string
    add_column :users, :street_number, :string
    add_column :users, :locality, :string
    add_column :users, :administrative_area_level_1, :string
    add_column :users, :administrative_area_level_2, :string
    add_column :users, :country, :string
    add_column :users, :postal_code, :string
  end
end
