require 'rails_helper'
require 'csv'

RSpec.describe RentRollProcessor, type: :service do
  let(:file_path) { Rails.root.join('spec', 'fixtures', 'rent_roll_fixture.csv') }

  before(:all) do
    # Start from a clean state to avoid any possible flaky behavior
    Unit.destroy_all
    Tenant.destroy_all
    Lease.destroy_all
  end

  describe '.process' do
    it 'correctly processes the rent roll fixture and creates records' do
      expect {
        RentRollProcessor.process(file_path)
      }.to change { Unit.count }.by(4).and change { Tenant.count }.by(4).and change { Lease.count }.by(4)

      expect(Unit.find_by(unit_number: '01')).to be_present
      expect(Unit.find_by(unit_number: '10')).to be_present
      expect(Unit.find_by(unit_number: '05')).to be_present
      expect(Unit.find_by(unit_number: '06')).to be_present

      expect(Tenant.find_by(name: 'John W. Doe')).to be_present
      expect(Tenant.find_by(name: 'William C. Doe')).to be_present
      expect(Tenant.find_by(name: 'Bob Brown')).to be_present
      expect(Tenant.find_by(name: 'Jane L. Smith')).to be_present
      
      expect(Lease.count).to eq(4)

      lease1 = Lease.find_by(unit: Unit.find_by(unit_number: '01'), tenant: Tenant.find_by(name: 'John W. Doe'))
      lease2 = Lease.find_by(unit: Unit.find_by(unit_number: '10'), tenant: Tenant.find_by(name: 'William C. Doe'))
      lease3 = Lease.find_by(unit: Unit.find_by(unit_number: '05'), tenant: Tenant.find_by(name: 'Bob Brown'))
      lease4 = Lease.find_by(unit: Unit.find_by(unit_number: '06'), tenant: Tenant.find_by(name: 'Jane L. Smith'))

      expect(lease1.move_in).to eq(Date.parse('2023-08-01'))
      expect(lease1.move_out).to eq(Date.parse('2024-09-01'))
      expect(lease2.move_in).to eq(Date.parse('2024-08-01'))
      expect(lease2.move_out).to eq(Date.parse('2025-07-31'))
      expect(lease3.move_in).to eq(Date.parse('2024-08-10'))
      expect(lease3.move_out).to eq(Date.parse('2024-10-01'))
      expect(lease4.move_in).to eq(Date.parse('2023-08-10'))
      expect(lease4.move_out).to eq(Date.parse('2024-10-01'))
    end

    it 'handles empty file gracefully' do
      empty_file_path = Rails.root.join('spec', 'fixtures', 'empty_rent_roll_fixture.csv')
      File.write(empty_file_path, '')

      expect {
        RentRollProcessor.process(empty_file_path)
      }.to change { Unit.count }.by(0).and change { Tenant.count }.by(0).and change { Lease.count }.by(0)
    end
  end
end
