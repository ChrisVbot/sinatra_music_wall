class Song < ActiveRecord::Base
  validates :author, presence: true, length: {maximum: 25}
  validates :title, presence: true, length: {maximum: 100}
  validates :url, format: {with: URI.regexp}, allow_blank: true
end

