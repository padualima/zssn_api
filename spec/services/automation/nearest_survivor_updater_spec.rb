require 'rails_helper'
require './app/services/automation/nearest_survivor_updater'

RSpec.describe Automation::NearestSurvivorUpdater do
  let(:location) { build(:location_feature, :with_survivor_nearby) }

  subject { Automation::NearestSurvivorUpdater.call(location) }

  describe "#call" do
    let(:nearest_location) { LocationFeature.by_nearby(location).first }

    before do
      location.save
    end

    it 'should update when exists nearest survivor' do
      expect(subject).to eql(location)
      expect(location.nearest_survivor_id).to eql(nearest_location.survivor_id)
    end

    it 'should not update when not exists nearest survivor' do
      nearest_location.destroy

      expect(subject).to eql(nil)
    end

    it 'shuold not update when resource not is a LocationFeature' do
      expect { Automation::NearestSurvivorUpdater.call(location.survivor) }
        .to raise_error(TypeError)
    end
  end
end
