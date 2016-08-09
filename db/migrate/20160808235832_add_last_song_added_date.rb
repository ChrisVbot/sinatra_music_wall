class AddLastSongAddedDate < ActiveRecord::Migration
  def change
    add_column :users, :last_song_added_at, :datetime
  end
end

