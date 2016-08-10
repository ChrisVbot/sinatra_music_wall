class AddReviewTable < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :song, foreign_key: true
      t.string :review
      t.timestamps
    end
  end
end
