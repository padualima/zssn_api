module Actions
  module RecordStrategy
    class Base
      def save(record_data, log)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      protected

      def is_refugees?(log, reported, informed_by)
        range = %w(infected recovered)

        if reported.status.in?(range)
          log.warn("Survivor_id=#{reported.id} ReportedNotIsRefugee")
          raise 'ReportedNotIsRefugee'
        end

        if informed_by&.status.in?(range)
          log.warn("Survivor_id=#{informed_by.id} ReportedNotIsRefugee")

          raise 'WhoReportedIsNotRefugee'
        end
      end

      def survivors_is_nearby?(log, reported, informed_by)
        nearby_locations = LocationFeature.by_nearby(reported.location_feature)

        unless nearby_locations.exists?(id: informed_by.location_feature)
          log.warn("Survivor_ids=#{[reported.id, informed_by.id]} SurvivorsAreNotNear")

          raise('SurvivorsAreNotNear')
        end
      end

      def already_reported?(log, reported, informed_by)
        if Record.exists?(survivor_id: reported, by_survivor: informed_by)
          log.warn("Survivor_id=#{informed_by.id} AlreadyRecordOfSurvivor")

          raise('AlreadyRecordOfSurvivor')
        end
      end
    end
  end
end
