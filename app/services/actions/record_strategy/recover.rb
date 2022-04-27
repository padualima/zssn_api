module Actions
  module RecordStrategy
    class Recover < Base
      def save(record_data, log)
        reported = Survivor.find(record_data[:survivor_id])
        by_report = nil

        unless record_data[:by_survivor_id].nil?
          by_report = Survivor.find(record_data[:by_survivor_id])
        end

        full_requirements?(reported, by_report)

        record = Record.new(record_data)
        reported.redeem! if record.save!

        record
      end

      private

      def full_requirements?(reported, by_report=nil)
        is_refugees?(reported, by_report)

        if by_report.present?
          survivors_is_nearby?(reported, by_report)
          already_reported?(reported, by_report)
        end
      end
    end
  end
end
