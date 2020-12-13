class CreateLeaderboardEntryScores < ActiveRecord::Migration[5.1]
  def change
    create_table :leaderboard_entry_scores do |t|
      t.references :leaderboard_entry, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
