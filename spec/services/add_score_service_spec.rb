require 'rails_helper'

RSpec.describe AddScoreService do
  fixtures :leaderboards
  fixtures :leaderboard_entries

  let(:my_leaderboard) { leaderboards(:my_leaderboard) }
  let(:renan) { leaderboard_entries(:renan) }

  let(:existing_username_valid_params) {
    { username: 'Renan', score: '5' }
  }

  let(:existing_username_invalid_params) {
    { username: 'Renan', score: '5m' }
  }

  let(:new_username_valid_params) {
    { username: 'Fulano', score: '3' }
  }

  let(:new_username_invalid_params) {
    { username: 'Fulano', score: '2m' }
  }

  describe '#call' do
    context "with valid params" do

      context 'existing username' do
        it 'add score to leaderboarder entry' do
          expect {
            AddScoreService.new(leaderboard: my_leaderboard, params: existing_username_valid_params).call
          }.to change { renan.reload.score }.by(5)
        end

        it 'add creates a new leaderboarder entry score' do
          expect {
            AddScoreService.new(leaderboard: my_leaderboard, params: existing_username_valid_params).call
          }.to change { LeaderboardEntryScore.count }.by(1)
        end
      end

      context 'new username' do
        it 'creates new leaderboarder entry with score' do
          expect {
            AddScoreService.new(leaderboard: my_leaderboard, params: new_username_valid_params).call
          }.to change { LeaderboardEntry.count }.by(1)
        end

        it 'add creates a new leaderboarder entry score' do
          expect {
            AddScoreService.new(leaderboard: my_leaderboard, params: new_username_valid_params).call
          }.to change { LeaderboardEntryScore.count }.by(1)
        end
      end

    end

    context "with invalid params" do
      context 'existing username' do
        it 'does not changes the score' do
          expect {
            AddScoreService.new(leaderboard: my_leaderboard, params: existing_username_invalid_params).call
          }.not_to change { renan.reload.score }
        end

        it 'does not creates a new leaderboarder entry score' do
          expect {
            AddScoreService.new(leaderboard: my_leaderboard, params: existing_username_invalid_params).call
          }.not_to change { LeaderboardEntryScore.count }
        end
      end

      context 'new username' do
        it 'does not creates new leaderboarder entry' do
          expect {
            AddScoreService.new(leaderboard: my_leaderboard, params: new_username_invalid_params).call
          }.not_to change { LeaderboardEntry.count }
        end

        it 'does not creates a new leaderboarder entry score' do
          expect {
            AddScoreService.new(leaderboard: my_leaderboard, params: new_username_invalid_params).call
          }.not_to change { LeaderboardEntryScore.count }
        end
      end
    end
  end
end
