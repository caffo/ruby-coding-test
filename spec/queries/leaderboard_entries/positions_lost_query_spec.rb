require 'rails_helper'

RSpec.describe LeaderboardEntries::PositionsLostQuery do
  fixtures :leaderboards
  fixtures :leaderboard_entries

  let(:my_leaderboard) { leaderboards(:my_leaderboard) }
  let(:rodrigo) { leaderboard_entries(:rodrigo) }

  describe '#call' do
    it 'returns the total positions gained by entry for the new score' do
      positions = LeaderboardEntries::PositionsLostQuery.new(my_leaderboard.entries)
        .call(entry_id: rodrigo.id, new_score: 7, old_score: rodrigo.score)

      expect(positions).to eq(1)
    end
  end
end
