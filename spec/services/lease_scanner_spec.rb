require 'rails_helper'

RSpec.describe LeaseScanner, type: :service do
  let(:unit) { Unit.create(unit_number: '101', floor_plan: :studio) }
  let(:unit_2) { Unit.create(unit_number: '103', floor_plan: :studio) }
  
  before do
    @lease1 = Lease.create(unit: unit, tenant: Tenant.create(name: 'John Doe'), move_in: '2023-01-01', move_out: '2024-12-31')
    @lease2 = Lease.create(unit: unit_2, tenant: Tenant.create(name: 'Jane Smith'), move_in: '2024-01-01', move_out: '2025-01-30')
    @lease3 = Lease.create(unit: Unit.create(unit_number: '102', floor_plan: :suite), tenant: Tenant.create(name: 'Jane Smith'), move_in: '2024-09-15', move_out: '2025-01-15')
  end

  describe '.leases' do
    context 'when there are leases active on the specified date' do
      it 'returns active leases' do
        expect(LeaseScanner.leases('2024-08-01')).to include(@lease1, @lease2)
        expect(LeaseScanner.leases('2024-08-01')).not_to include(@lease3)
      end
    end

    context 'when there are no active leases on the specified date' do
      it 'returns an empty array' do
        expect(LeaseScanner.leases('2025-07-01')).to be_empty
      end
    end
  end

  describe '.vacant_units' do
    context 'when there are occupied units' do
      it 'returns vacant units' do
        expect(LeaseScanner.vacant_units('2024-08-01')).to include(Unit.find_by(unit_number: '102'))
        expect(LeaseScanner.vacant_units('2024-08-01')).not_to include(unit)
      end
    end

    context 'when all units are occupied' do
      it 'returns an empty array' do
        expect(LeaseScanner.vacant_units('2024-10-20')).to be_empty
      end
    end
  end

  describe '.generate_report' do
    context 'when there are active leases on the given date' do
      it 'returns formatted string for active leases' do
        report_output = LeaseScanner.generate_report(Date.parse('2024-08-15'))
        
        expect(report_output[0]).to include("2 Leases on 2024-08-15:")
        expect(report_output[0]).to include("Unit 101, Tenant: John Doe, Move In: 2023-01-01, Move Out: 2024-12-31")
        expect(report_output[0]).to include("Unit 103, Tenant: Jane Smith, Move In: 2024-01-01, Move Out: 2025-01-30")
      end
    end

    context 'when there are no active leases on the given date' do
      it 'returns a message saying no leases are active' do
        report_output = LeaseScanner.generate_report(Date.parse('2022-08-15'))

        expect(report_output[0]).to include("No leases active on 2022-08-15.")
      end
    end

    context 'when there are vacant units on the given date' do
      it 'lists vacant units correctly' do
        vacant_units_report = LeaseScanner.generate_report(Date.parse('2001-08-15'))

        expect(vacant_units_report[1]).to include("3 Vacant units on 2001-08-15:")
        expect(vacant_units_report[1]).to include("Unit 101, Floor Plan: studio")
        expect(vacant_units_report[1]).to include("Unit 102, Floor Plan: suite")
        expect(vacant_units_report[1]).to include("Unit 103, Floor Plan: studio")
      end
    end

    context 'when all units are occupied' do
      it 'shows no vacant units message' do
        vacant_units_report = LeaseScanner.generate_report(Date.parse('2024-10-01'))

        expect(vacant_units_report[1]).to include("No vacant units on 2024-10-01.")
      end
    end
  end
end
