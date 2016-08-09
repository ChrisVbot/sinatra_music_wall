class User < ActiveRecord::Base
  has_many :songs

  validates :username, presence: true, length:{minimum:5}
  validates :password, presence: true


end