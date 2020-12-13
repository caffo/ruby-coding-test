class LeaderboardEntryScore < ApplicationRecord
  validates :score, numericality: true

  belongs_to :entry, class_name: 'LeaderboardEntry', foreign_key: 'leaderboard_entry_id'
end
