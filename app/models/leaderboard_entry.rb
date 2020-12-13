class LeaderboardEntry < ApplicationRecord
  validates :score, numericality: true

  belongs_to :leaderboard

  scope :classified, -> { order(score: :desc) }
end
