require 'rails_helper'

RSpec.describe Record, type: :model do
  context '#relationships' do
    it { is_expected.to belong_to(:survivor) }
    it { is_expected.to belong_to(:by_survivor).class_name('Survivor').optional }
  end

  context '#validations' do
    it { should validate_presence_of(:kind) }
  end
end
