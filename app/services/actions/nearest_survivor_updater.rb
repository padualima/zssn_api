module Actions
  class NearestSurvivorUpdater < ApplicationService
    def initialize(location)
      raise TypeError, 'Expected `LocationFeature`' unless location.is_a? LocationFeature

      @location = location
      @logger = Rails.logger
    end

    def call
      @logger.info("[NearestSurvivorUpdater] initial resource_id=#{@location.id}")

      nearby = LocationFeature.by_nearby(@location)&.first

      if nearby.nil?
        @location.survivor.errors.add(:base, "NotSurvivorAround")
        return nil
      end

      @location.assign_attributes(nearest_survivor_id: nearby&.survivor_id)
      @location.save! if @location.changed?

      @logger.info("[NearestSurvivorUpdater] finished resource_id=#{@location.id}")

      @location
    rescue => e
      @logger.error("[NearestSurvivorUpdater] error resource_id=#{@location.id} m=#{e.message}")

      raise e
    end
  end
end
