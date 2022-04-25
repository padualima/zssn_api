require 'rails_helper'

RSpec.describe LocationFeature, type: :model do
  context '#relationships' do
    it { is_expected.to belong_to(:survivor) }
    it { is_expected.to belong_to(:nearest_survivor).class_name('Survivor').optional }
  end

  context '#validations' do
    subject { build(:location_feature) }

    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_numericality_of(:latitude) }
    it { should validate_numericality_of(:longitude) }
    it 'should exists the nearest_survivor_id' do
      subject.nearest_survivor_id = Survivor.count.next

      expect(subject).to be_invalid
      expect(subject.errors[:nearest_survivor_id]).to include('was not found')
    end
  end

  context "#methods" do
    subject { build(:location_feature) }

    before do
      subject.save
    end

    it '.location' do
      expect(subject.location).to be_a(Array)
      expect(subject.location.count).to be(2)
    end
  end

  context "#create" do
    subject { build(:location_feature) }

    context 'should save location_feature' do
      it 'when required attributes is present' do
        expect { subject.save }.to change(LocationFeature, :count)
        expect(subject.persisted?).to be true
      end
    end

    context 'should not save location_feature' do
      it 'when not exists survivor_id' do
        subject.survivor = nil

        expect { subject.save }.to_not change(LocationFeature, :count)
        expect(subject.persisted?).to be false
      end

      it 'when nearest_survivor_id was not found' do
        subject.nearest_survivor_id = Survivor.count.next

        expect { subject.save }.to_not change(LocationFeature, :count)
        expect(subject.errors[:nearest_survivor_id]).to include('was not found')
        expect(subject.persisted?).to be false
      end
    end
  end
end
