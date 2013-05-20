class AddClosedToItems < ActiveRecord::Migration
  def change
    add_column :items, :closed, :boolean
  end
end
