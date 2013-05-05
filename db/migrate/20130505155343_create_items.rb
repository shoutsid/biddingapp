class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
      t.belongs_to :category
      t.float :min_accept_bid
      t.float :starting_price

      t.timestamps
    end
  end
end
