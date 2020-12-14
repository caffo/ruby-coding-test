class LeaderboardEntryScoresController < ApplicationController
  before_action :set_leaderboard_entry_score, only: [:destroy]

  def destroy
    leaderboard = @leaderboard_entry_score.entry.leaderboard

    result = RemoveScoreService.new(@leaderboard_entry_score).call

    redirect_to leaderboard, notice: "Score was successfully removed. Lost #{result.positions_lost} position(s)."
  end

  private

  def set_leaderboard_entry_score
    @leaderboard_entry_score = LeaderboardEntryScore.find(params[:id])
  end
end
