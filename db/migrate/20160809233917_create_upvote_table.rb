class CreateUpvoteTable < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.references :user, foreign_key: true
      t.references :song, foreign_key: true
      t.timestamps
    end
  end
end
