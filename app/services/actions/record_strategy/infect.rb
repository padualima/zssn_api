module Actions
  module RecordStrategy
    class Infect < Base
      def save(record_data, log)
        reported = Survivor.find(record_data[:survivor_id])
        by_report = Survivor.find(record_data[:by_survivor_id])

        full_requirements?(log, reported, by_report)

        record = Record.new(record_data)

        if record.save!
          records = Record.where(survivor: reported, kind: Record.kinds[0])
          if records.count == 3
            if reported.infect!
              log.warn("Survivor_id=#{reported.id} Infected")
            end
          end
        end

        record
      end

      protected

      def full_requirements?(log, reported, by_report)
        is_refugees?(log, reported, by_report)
        survivors_is_nearby?(log, reported, by_report)
        already_reported?(log, reported, by_report)
      end
    end
  end
end
