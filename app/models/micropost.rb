class Micropost < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :wall

  scope :sorted, -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 140}
end
