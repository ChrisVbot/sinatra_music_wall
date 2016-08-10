class Song < ActiveRecord::Base
  
  belongs_to :user
  has_many :upvotes

  validates :author, presence: true, length: {maximum: 25}
  validates :title, presence: true, length: {maximum: 100}
  validates :url, format: {with: URI.regexp}, allow_blank: true
  validates :total_updates, numericality: {only_integer: true}

  after_save :update_last_song_added_at_field


  def update_last_song_added_at_field
    user.update(last_song_added_at: DateTime.now)
  end

end

