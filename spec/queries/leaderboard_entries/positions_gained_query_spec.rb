require 'rails_helper'

RSpec.describe LeaderboardEntries::PositionsGainedQuery do
  fixtures :leaderboards
  fixtures :leaderboard_entries

  let(:my_leaderboard) { leaderboards(:my_leaderboard) }
  let(:paul) { leaderboard_entries(:paul) }

  describe '#call' do
    it 'returns the total positions gained by entry for the new score' do
      positions = LeaderboardEntries::PositionsGainedQuery.new(my_leaderboard.entries)
        .call(entry_id: paul.id, new_score: 20, old_score: paul.score)

      expect(positions).to eq(2)
    end
  end
end
