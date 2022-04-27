module Automation
  class NearestSurvivorUpdaterJob
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def perform(survivor_id)
      @logger = Rails.logger
      survivor = Survivor.find(survivor_id)

      @logger.warn("Updating the nearest survivor to survivor_id#{survivor.id}")
      Actions::NearestSurvivorUpdater.call(survivor.location)
    end
  end
end
