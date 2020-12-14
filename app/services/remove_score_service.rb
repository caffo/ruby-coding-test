class RemoveScoreService
  def initialize(leaderboard_entry_score)
    @leaderboard_entry_score = leaderboard_entry_score
    @entry = leaderboard_entry_score.entry
  end

  def call
    positions = 0

    ActiveRecord::Base.transaction do
      positions = positions_lost(entry)
      entry.update!(score: new_score)
      leaderboard_entry_score.destroy!
    end

    OpenStruct.new(success?: true, positions_lost: positions)
  end

  private

  attr_reader :leaderboard_entry_score, :entry

  def new_score
    entry.score.to_i - leaderboard_entry_score.score
  end

  def positions_lost(entry)
    LeaderboardEntries::PositionsLostQuery.new(entry.leaderboard.entries)
      .call(entry_id: entry.id, new_score: new_score, old_score: entry.score)
  end
end
