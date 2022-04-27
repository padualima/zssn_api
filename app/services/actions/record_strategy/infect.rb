module Actions
  module RecordStrategy
    class Infect < Base
      def save(record_data, log)
        reported = Survivor.find(record_data[:survivor_id])
        by_report = Survivor.find(record_data[:by_survivor_id])

        full_requirements?(reported, by_report)

        record = Record.new(record_data)

        if record.save!
          records = Record.where(survivor: reported, kind: Record.kinds[0])
          report.infect! if records.count == 3
        end

        record
      end

      private

      def full_requirements?(reported, by_report)
        is_refugees?(reported, by_report)
        survivors_is_nearby?(reported, by_report)
        already_reported?(reported, by_report)
      end
    end
  end
end
