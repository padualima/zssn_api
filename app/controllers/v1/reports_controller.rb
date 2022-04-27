class V1::ReportsController < V1::ApiController
  def stats
    @survivors = Survivor
      .joins(:location_feature)
      .select(
        %(
          survivors.id,
          survivors.name,
          survivors.status,
          survivors.gender,
          (location_features.latitude, location_features.longitude) AS location
        )
      )
      .order(:id)

    render(json: @survivors, adapter: :json, meta: meta)
  end

  def meta
      {
        count_not_infected: @survivors.refugees.count(:id),
        count_infected: @survivors.infecteds.count(:id),
        count_recovered: @survivors.recovereds.count(:id)
      }
  end
end
