class AddScoreService
  include ActiveModel::Validations

  validates :score, numericality: true

  def initialize(leaderboard:, params:)
    @leaderboard = leaderboard
    @username = params[:username]
    @score = params[:score]
  end

  def call
    return OpenStruct.new(success?: false, errors: self.errors) unless valid?

    positions = 0

    ActiveRecord::Base.transaction do
      entry = leaderboard.entries.find_or_create_by!(username: username)
      positions = positions_gained(entry)
      entry.update!(score: new_score(entry))
      LeaderboardEntryScore.create!(score: score, entry: entry)
    end

    OpenStruct.new(success?: true, positions_gained: positions)
  end

  private

  attr_reader :leaderboard, :username, :score

  def new_score(entry)
    score.to_i + entry.score.to_i
  end

  def positions_gained(entry)
    LeaderboardEntries::PositionsGainedQuery.new(leaderboard.entries)
      .call(entry_id: entry.id, new_score: new_score(entry), old_score: entry.score)
  end
end
