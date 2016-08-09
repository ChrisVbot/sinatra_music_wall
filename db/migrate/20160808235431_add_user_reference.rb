class AddUserReference < ActiveRecord::Migration
  def change
    add_reference :songs, :user, foreign_key: true
  end
end

