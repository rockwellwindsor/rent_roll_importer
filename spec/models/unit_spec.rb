require 'rails_helper'

RSpec.describe Unit, type: :model do
  subject { described_class.new }

  let(:unit) { Unit.create(unit_number: '10', floor_plan: :studio) }
  let(:tenant) { Tenant.create(name: 'John Doe') }

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

  it 'can have many Leases' do
    lease = Lease.create(unit: unit, tenant: tenant, move_in: '2023-08-01', move_out: '2024-08-31')
    expect(unit.leases).to include(lease)
  end

  it 'can have many Tenants' do
    lease = Lease.create(unit: unit, tenant: tenant, move_in: '2023-08-01', move_out: '2024-08-31')
    expect(unit.tenants).to include(tenant)
  end
end
