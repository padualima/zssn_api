module Automation
  class NearestSurvivorUpdater < ApplicationService
    def initialize(location)
      raise TypeError, 'Expected `LocationFeature`' unless location.is_a? LocationFeature

      @location = location
      @logger = Rails.logger
    end

    def call
    end
  end
end
