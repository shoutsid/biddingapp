class AddBidsCountToItems < ActiveRecord::Migration
  def change
    add_column :items, :bids_count, :integer, default: 0

    Item.find_each do |item|
      User.reset_counters(item.id, :bids)
    end
  end
end
