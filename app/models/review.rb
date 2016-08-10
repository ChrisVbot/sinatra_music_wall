class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :review, presence: true, length:{minimum: 5, maximum: 140}

  
end