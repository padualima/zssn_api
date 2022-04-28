module Actions
  module RecordStrategy
    class Infect < Base
      def save(record_data, log)
        reported = Survivor.find(record_data[:survivor_id])
        informed_by = Survivor.find(record_data[:by_survivor_id])

        full_requirements?(log, reported, informed_by)

        record = Record.new(record_data)

        if record.save!
          records = Record.where(survivor: reported, kind: Record.kinds.keys[0])
          if records.count == 3
            if reported.infect!
              log.warn("Survivor_id=#{reported.id} Infected")
            end
          end
        end

        record
      end

      protected

      def full_requirements?(log, reported, informed_by)
        is_refugees?(log, reported, informed_by)
        survivors_is_nearby?(log, reported, informed_by)
        already_reported?(log, reported, informed_by)
      end
    end
  end
end
