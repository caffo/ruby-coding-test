class LeaderboardEntry < ApplicationRecord
  validates :score, numericality: true

  belongs_to :leaderboard
  has_many :leaderboard_entry_scores, dependent: :destroy

  scope :classified, -> { order(score: :desc) }
end
