module LeaderboardEntries
  class PositionsLostQuery
    def initialize(entries = LeaderboardEntry.all)
      @entries = entries
    end

    def call(params)
      @entries.where.not(id: params[:entry_id])
        .where('score > ?', params[:new_score])
        .where('score < ?', params[:old_score])
        .count
    end
  end
end
