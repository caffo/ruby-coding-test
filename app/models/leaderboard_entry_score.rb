class LeaderboardEntryScore < ApplicationRecord
  validates :score, numericality: true

  belongs_to :leaderboard_entry
end
