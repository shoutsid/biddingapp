class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :amount, precision: 8, scale: 2, null: false, default: 0
      t.belongs_to :user, index: true
      t.belongs_to :item, index: true

      t.timestamps
    end
  end
end
