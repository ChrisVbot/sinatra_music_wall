class Song < ActiveRecord::Base
  
  belongs_to :user

  validates :author, presence: true, length: {maximum: 25}
  validates :title, presence: true, length: {maximum: 100}
  validates :url, format: {with: URI.regexp}, allow_blank: true

  after_save :update_last_song_added_at_field


  def update_last_song_added_at_field
    user.update(last_song_added_at: DateTime.now)
  end

end

