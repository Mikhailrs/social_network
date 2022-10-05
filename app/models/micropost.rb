class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :wall

  scope :sorted, -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 255}
end
