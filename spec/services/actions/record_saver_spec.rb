require 'rails_helper'
require './app/services/actions/record_saver'

RSpec.describe Actions::RecordSaver do
  # subject { Actions::RecordSaver.call(location) }

  describe "#call" do
    context 'save record infect' do
      let(:survivor) { create(:survivor, :with_nearest_survivor) }
      let(:location) { survivor.location_feature }
      let(:record_data) do
        {
          survivor_id: survivor.id,
          by_survivor_id: survivor.nearest_survivor.id,
          kind: Record.kinds.keys[0]
        }
      end

      subject { Actions::RecordSaver.call(record_data) }

      it 'sholud save record when survivor_report not record infect' do
        expect(subject).to eql(survivor.records.first)
      end
      #   given
      #     survivors proximos,
      #       survivor_id without record infect when call service return record
      #       survivor_id with 2 record infect when call service return record and survivor_id infect
      #       survivor_id with 2 record infect when call service return and survivor_id infect
      #       by_suvivor has already registered a record for survivor retrun HasAlreadyRegisteredRecord
      #     whihout survivor
      #       when call service return NotFound
    end

    context 'save record recovered' do
      context 'if by_survivor is nil' do
        let(:survivor) { create(:survivor) }
        let(:location) { survivor.location_feature }
        let(:record_data) do
          {
            survivor_id: survivor.id,
            kind: Record.kinds.keys[1]
          }
        end

        subject { Actions::RecordSaver.call(record_data) }

        it 'sholud save record when survivor_report is recovered' do
          expect(subject).to eql(survivor.records.first)
        end
      end

      context 'if by_survivor is present' do
        let(:survivor) { create(:survivor, :with_nearest_survivor) }
        let(:location) { survivor.location_feature }
        let(:record_data) do
          {
            survivor_id: survivor.id,
            by_survivor_id: survivor.nearest_survivor.id,
            kind: Record.kinds.keys[1]
          }
        end

        subject { Actions::RecordSaver.call(record_data) }

        it 'sholud save record when survivor_report is recovered' do
          expect(subject).to eql(survivor.records.first)
        end
      end
    end
  end
end
