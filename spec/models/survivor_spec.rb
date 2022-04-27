require 'rails_helper'

RSpec.describe Survivor, type: :model do
  context '#relationships' do
    it { should accept_nested_attributes_for(:location_feature) }
  end

  context '#validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:gender) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:gender).with_values(Survivor.genders.keys) }
    it { should define_enum_for(:status).with_values(Survivor.statuses.keys) }
  end

  context '#create' do
    subject { build(:survivor) }

    context 'should save survivor' do
      it 'when required attributes is present' do
        expect { subject.save }.to change(Survivor, :count)
        expect(subject.persisted?).to be true
        expect(subject.location_feature.persisted?).to be true
        expect(subject.location.count).to be 2
        expect(described_class.name).to be_a String
        expect(described_class.genders).to include(subject.gender)
        expect(described_class.statuses).to include(subject.status)
      end
    end

    context 'should not save survivor' do
      it 'when the name is not present' do
        subject.name = ''

        expect { subject.save }.to_not change(Survivor, :count)
        expect(subject.save).to be false
      end

      it 'when the gender is not present' do
        subject.gender = nil

        expect { subject.save }.to_not change(Survivor, :count)
        expect(subject.save).to be false
      end

      it 'when the status is not present' do
        subject.gender = nil

        expect { subject.save }.to_not change(Survivor, :count)
        expect(subject.save).to be false
      end
    end
  end

  context '#aasm' do
    it 'should survivor starts as a refugee' do
      expect(subject.status).to eql('refugee')
    end

    # TODO: adjust when add table records
    it 'should when the survivor is infected to change status' do
      subject.infect
      expect(subject.status).to eql('infected')
    end

    # TODO: adjust when add table records
    it 'should when the survivor is recovered it will change its status' do
      subject.redeem
      expect(subject.status).to eql('recovered')
    end
  end
end
