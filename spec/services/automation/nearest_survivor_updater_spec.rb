require 'rails_helper'

RSpec.describe NearestSurvivorUpdater do
  subject { create(:survivor, :with_location) }

  it 'should update when location updated'
  it 'should update when not exists nearest survivor'
  it 'shuold not update when resource not is a LocationFeature'
  it 'should not update when location not updated'
end
