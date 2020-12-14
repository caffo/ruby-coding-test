module LeaderboardEntries
  class PositionsGainedQuery
    def initialize(entries = LeaderboardEntry.all)
      @entries = entries
    end

    def call(params)
      @entries.where.not(id: params[:entry_id])
        .where('score < ?', params[:new_score] || 0)
        .where('score > ?', params[:old_score] || 0 )
        .count
    end
  end
end
