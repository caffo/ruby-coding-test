class AddDefaultScoreAsZero < ActiveRecord::Migration[5.1]
  def change
    change_column_default :leaderboard_entries, :score, 0
  end
end
