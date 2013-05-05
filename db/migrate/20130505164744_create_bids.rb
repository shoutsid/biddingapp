class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :price, precision: 8, scale: 2
      t.belongs_to :user, index: true
      t.belongs_to :item, index: true

      t.timestamps
    end
  end
end
