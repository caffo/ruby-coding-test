class AddScoreService
  include ActiveModel::Validations

  validates :score, numericality: true

  def initialize(leaderboard:, params:)
    @leaderboard = leaderboard
    @username = params[:username]
    @score = params[:score]
  end

  def call
    return false unless valid?

    ActiveRecord::Base.transaction do
      entry = leaderboard.entries.find_or_create_by!(username: username)
      entry.update!(score: new_score(entry))
      LeaderboardEntryScore.create!(score: score, entry: entry)
    end
  end

  private

  attr_reader :leaderboard, :username, :score

  def new_score(entry)
    score.to_i + entry.score.to_i
  end
end
