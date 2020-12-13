require 'rails_helper'

RSpec.describe LeaderboardEntryScoresController, type: :controller do
  fixtures :leaderboard_entries
  fixtures :leaderboard_entry_scores

  let(:renan_3) { leaderboard_entry_scores(:renan_3) }
  let(:renan) { leaderboard_entries(:renan) }

  describe 'DELETE #destroy' do
    it 'destroy the leaderboard_entry_score' do
      expect {
        delete :destroy, params: { id: renan_3.id }
      }.to change { LeaderboardEntryScore.count }.by(-1)
    end

    it 'updates the score of the leaderboard_entry' do
      expect {
        delete :destroy, params: { id: renan_3.id }
      }.to change { renan.reload.score }.by(-3)
    end
  end
end
