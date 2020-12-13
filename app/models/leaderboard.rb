class Leaderboard < ApplicationRecord
  has_many :entries, class_name: 'LeaderboardEntry'
  has_many :leaderboard_entry_scores, through: :entries
end
