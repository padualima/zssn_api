module Actions
  module RecordStrategy
    class Recover < Base
      def save(record_data, log)
        reported = Survivor.find(record_data[:survivor_id])
        informed_by = nil

        unless record_data[:by_survivor_id].nil?
          informed_by = Survivor.find(record_data[:by_survivor_id])
        end

        full_requirements?(log, reported, informed_by)

        record = Record.new(record_data)

        if record.save!
          if reported.redeem!
            informed_by.redeem! if informed_by.present?

            log.warn("Survivor_ids=#{[reported.id, informed_by&.id]} Recovereds")
          end
        end

        record
      end

      protected

      def full_requirements?(log, reported, informed_by=nil)
        is_refugees?(log, reported, informed_by)

        if informed_by.present?
          survivors_is_nearby?(log, reported, informed_by)
          already_reported?(log, reported, informed_by)
        end
      end
    end
  end
end
