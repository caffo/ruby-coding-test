require 'rails_helper'

RSpec.describe RemoveScoreService do
  fixtures :leaderboard_entries
  fixtures :leaderboard_entry_scores

  let(:renan_3) { leaderboard_entry_scores(:renan_3) }
  let(:renan) { leaderboard_entries(:renan) }

  describe '#call' do
    it 'destroy the leaderboard_entry_score' do
      expect {
        RemoveScoreService.new(renan_3).call
      }.to change { LeaderboardEntryScore.count }.by(-1)
    end

    it 'updates the score of the leaderboard_entry' do
      expect {
        RemoveScoreService.new(renan_3).call
      }.to change { renan.reload.score }.by(-3)
    end
  end
end
