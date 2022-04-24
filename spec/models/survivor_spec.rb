require 'rails_helper'

RSpec.describe Survivor, type: :model do
  describe "#create" do
    subject(:survivor) { build(:survivor) }

    context 'should save survivor' do
      it 'when required attributes is present' do
        expect { survivor.save }.to change(Survivor, :count)
        expect(survivor.persisted?).to be true
        expect(described_class.name).to be_a String
        expect(described_class.genders).to include(survivor.gender)
        expect(described_class.statuses).to include(survivor.status)
      end
    end

    context 'should not save survivor' do
      it 'when the name is not present' do
        survivor.name = ''

        expect { survivor.save }.to_not change(Survivor, :count)
        expect(survivor.save).to be false
      end

      it 'when the gender is not present' do
        survivor.gender = nil

        expect { survivor.save }.to_not change(Survivor, :count)
        expect(survivor.save).to be false
      end

      it 'when the status is not present' do
        survivor.gender = nil

        expect { survivor.save }.to_not change(Survivor, :count)
        expect(survivor.save).to be false
      end
    end
  end
end
