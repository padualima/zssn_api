module Actions
  module RecordStrategy
    class Recover < Base
      def save(record_data, log)
        reported = Survivor.find(record_data[:survivor_id])
        by_report = nil

        unless record_data[:by_survivor_id].nil?
          by_report = Survivor.find(record_data[:by_survivor_id])
        end

        full_requirements?(log, reported, by_report)

        record = Record.new(record_data)

        if record.save!
          if reported.redeem!
            by_report.redeem! if by_report.present?

            log.warn("Survivor_ids=#{[reported.id, by_report&.id]} Recovereds")
          end
        end

        record
      end

      protected

      def full_requirements?(log, reported, by_report=nil)
        is_refugees?(log, reported, by_report)

        if by_report.present?
          survivors_is_nearby?(log, reported, by_report)
          already_reported?(log, reported, by_report)
        end
      end
    end
  end
end
