class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
      t.belongs_to :category
      t.decimal :min_accept_bid
      t.decimal :starting_price
      t.string :highest_bid_id
      t.datetime :closing_time

      t.timestamps
    end
  end
end
