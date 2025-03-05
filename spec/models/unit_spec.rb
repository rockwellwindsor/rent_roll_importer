require 'rails_helper'

RSpec.describe Unit, type: :model do
  subject { described_class.new }

  it 'requires a unit_name' do
    subject.unit_number = nil
    subject.floor_plan = 1
    expect(subject).not_to be_valid
  end

  it 'requires a floor_plan' do
    subject.unit_number = '1A'
    subject.floor_plan = nil
    expect(subject).not_to be_valid
  end

  it 'is valid with all required attributes' do
    subject.unit_number = '1A'
    subject.floor_plan = 1
    expect(subject).to be_valid
  end
end
