class AddUpvotes < ActiveRecord::Migration
  def change
    add_column :songs, :total_upvotes, :integer
  end
end
