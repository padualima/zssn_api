module Actions
  module RecordStrategy
    class Base
      def save(record_data, log)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      protected

      def is_refugees?(reported, by_report)
        range = %w(infected recovered)
        condition = reported.status.in?(range) || by_report&.status.in?(range)

        raise 'ReportedNotIsRefugee'if condition
        raise 'WhoReportedIsNotRefugee' if condition
      end

      def survivors_is_nearby?(reported, by_report)
        raise('SurvivorsAreNotNear') unless LocationFeature
          .by_nearby(reported.location_feature)
          .exists?(id: by_report.location_feature)
      end

      def already_reported?(reported, by_report)
        raise('AlreadyRecordOfSurvivor') if
          Record.exists?(survivor_id: reported, by_survivor: by_report)
      end
    end
  end
end
