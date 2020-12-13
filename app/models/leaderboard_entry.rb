class LeaderboardEntry < ApplicationRecord
  belongs_to :leaderboard

  scope :classified, -> { order(score: :desc) }
end
