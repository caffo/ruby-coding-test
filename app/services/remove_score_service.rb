class RemoveScoreService
  include ActiveModel::Validations

  validates :score, numericality: true

  def initialize(leaderboard_entry_score)
    @leaderboard_entry_score = leaderboard_entry_score
    @entry = leaderboard_entry_score.entry
  end

  def call
    ActiveRecord::Base.transaction do
      entry.update!(score: new_score)
      leaderboard_entry_score.destroy!
    end
  end

  private

  attr_reader :leaderboard_entry_score, :entry

  def new_score
    entry.score.to_i - leaderboard_entry_score.score
  end
end
