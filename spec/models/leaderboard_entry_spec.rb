require 'rails_helper'

RSpec.describe LeaderboardEntry, type: :model do
  fixtures :leaderboards
  fixtures :leaderboard_entries

  let(:my_leaderboard) { leaderboards(:my_leaderboard) }

  describe "#classified" do
    it "list leaderboard entries ordered by score desc" do
      entries = my_leaderboard.entries.classified.pluck(:username, :score)

      expect(entries.first).to eq(['Rodrigo', 10])
      expect(entries.second).to eq(['Renan', 9])
      expect(entries.third).to eq(['Paul', 0])
    end
  end
end
