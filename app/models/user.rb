class User < ActiveRecord::Base
  has_many :songs
  has_many :upvotes

  validates :username, presence: true, length:{minimum:5}
  validates :password, presence: true

  #Checks whether current user has upvoted for a specific song by checking that song's upvotes vs user's upvotes for that song. User can only vote once per song. This method called in songs/index so that the upvote button will only show up when user is logged in(current_user method) and have not voted for that specific song(has_already_upvoted method). 
  def has_already_upvoted?(song)
    upvotes.any? do |upvote|
      upvote.song_id == song.id
    end
  end

end