class AddBidsCountToItems < ActiveRecord::Migration
  def change
    add_column :items, :bids_count, :integer, default: 0
    Item.find_each do |item|
      item.update_attribute(:bids_count, item.bids.length)
      item.save
    end
  end
end
