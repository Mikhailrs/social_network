class Wall < ApplicationRecord
  has_many :microposts
  belongs_to :user

  validates :user_id, presence: true
end
