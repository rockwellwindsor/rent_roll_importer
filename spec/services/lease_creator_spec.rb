require 'rails_helper'

RSpec.describe LeaseCreator, type: :service do
  let(:unit) { Unit.create(unit_number: '101', floor_plan: :studio) }
  let(:tenant) { Tenant.create(name: 'John Doe') }

  describe '.create' do
    context 'when provided valid attributes' do
      it 'creates a lease' do
        move_in_date = Date.today
        move_out_date = Date.today + 30

        expect {
          LeaseCreator.create(unit, tenant, move_in_date, move_out_date)
        }.to change { Lease.count }.by(1)
      end
    end

    context 'when unit is not present' do
      it 'does not create a lease' do
        move_in_date = Date.today
        move_out_date = Date.today + 30

        expect {
          LeaseCreator.create(nil, tenant, move_in_date, move_out_date)
        }.not_to change { Lease.count }
      end
    end

    context 'when tenant is not present' do
      it 'does not create a lease' do
        move_in_date = Date.today
        move_out_date = Date.today + 30

        expect {
          LeaseCreator.create(unit, nil, move_in_date, move_out_date)
        }.not_to change { Lease.count }
      end
    end

    context 'when move_in date is blank' do
      it 'does not create a lease' do
        expect {
          LeaseCreator.create(unit, tenant, nil, Date.today + 30)
        }.not_to change { Lease.count }
      end
    end

    context 'when move_out date is blank' do
      it 'creates the lease' do
        expect {
          LeaseCreator.create(unit, tenant, Date.today, nil)
        }.to change { Lease.count }
      end
    end
  end
end
