class LeaderboardEntryScoresController < ApplicationController
  before_action :set_leaderboard_entry_score, only: [:destroy]

  def destroy
    leaderboard = @leaderboard_entry_score.entry.leaderboard

    RemoveScoreService.new(@leaderboard_entry_score).call

    redirect_to leaderboard, notice: 'Score was successfully removed.'
  end

  private

  def set_leaderboard_entry_score
    @leaderboard_entry_score = LeaderboardEntryScore.find(params[:id])
  end
end
