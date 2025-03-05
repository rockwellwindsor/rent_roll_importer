require 'rails_helper'

RSpec.describe Lease, type: :model do
  subject { described_class.new }

  let(:unit) { Unit.create(unit_number: '10', floor_plan: :studio) }
  let(:tenant) { Tenant.create(name: 'John Doe') }
  let(:move_in_date) { Date.parse('2025-03-01') }

  it 'belongs_to a Tenant' do
    subject.tenant = nil
    subject.unit = unit
    subject.move_in = move_in_date
    subject.move_out = nil
    expect(subject).not_to be_valid
  end

  it 'belongs_to a Unit' do
    subject.tenant = tenant
    subject.unit = nil
    subject.move_in = move_in_date
    subject.move_out = move_in_date + 1.year
    expect(subject).not_to be_valid
  end

  it 'requires a move_in date' do
    subject.tenant = tenant
    subject.unit = unit
    subject.move_in = nil
    subject.move_out = ''
    expect(subject).not_to be_valid
  end

  it 'is valid with all required attributes' do
    subject.tenant = tenant
    subject.unit = unit
    subject.move_in = move_in_date
    subject.move_out = move_in_date + 1.year
    expect(subject).to be_valid
  end
end
