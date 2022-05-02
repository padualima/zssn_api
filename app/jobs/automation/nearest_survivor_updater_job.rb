module Automation
  class NearestSurvivorUpdaterJob
    include Sidekiq::Job

    def perform(location_feature_id)
      @logger = Rails.logger
      location_feature = LocationFeature.find(location_feature_id)

      @logger.warn("Updating the nearest survivor to location_id#{location_feature.id}")
      Actions::NearestSurvivorUpdater.call(location_feature)
    end
  end
end
