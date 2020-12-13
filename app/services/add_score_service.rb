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

    entry = leaderboard.entries.find_or_create_by(username: username)
    entry.update(score: score.to_i + entry.score.to_i)
  end

  private

  attr_reader :leaderboard, :username, :score
end
