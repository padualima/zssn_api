module Actions
  module RecordStrategy
    class Base
      def save(record_data, log)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      protected

      def is_refugees?(log, reported, by_report)
        range = %w(infected recovered)

        if reported.status.in?(range)
          log.warn("Survivor_id=#{reported.id} ReportedNotIsRefugee")
          raise 'ReportedNotIsRefugee'
        end

        if by_report&.status.in?(range)
          log.warn("Survivor_id=#{by_report.id} ReportedNotIsRefugee")

          raise 'WhoReportedIsNotRefugee'
        end
      end

      def survivors_is_nearby?(log, reported, by_report)
        nearby_locations = LocationFeature.by_nearby(reported.location_feature)

        unless nearby_locations.exists?(id: by_report.location_feature)
          log.warn("Survivor_ids=#{[reported.id, by_report.id]} SurvivorsAreNotNear")

          raise('SurvivorsAreNotNear')
        end
      end

      def already_reported?(log, reported, by_report)
        if Record.exists?(survivor_id: reported, by_survivor: by_report)
          log.warn("Survivor_id=#{by_report.id} AlreadyRecordOfSurvivor")

          raise('AlreadyRecordOfSurvivor')
        end
      end
    end
  end
end
