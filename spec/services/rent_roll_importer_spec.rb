require 'rails_helper'

RSpec.describe RentRollImporter, type: :service do
  let(:valid_file_path) { Rails.root.join('spec', 'fixtures', 'rent_roll_fixture.csv') }
  let(:invalid_file_path) { 'non_existent_file.csv' }

  describe '.import' do
    it 'prints an error message and returns false when the file does not exist' do
      expect {
        RentRollImporter.import(invalid_file_path)
      }.to output("Please provide a valid CSV file path.\n").to_stdout
      expect(RentRollImporter.import(invalid_file_path)).to be false
    end

    it 'processes a valid CSV file and prints success message' do
      expect {
        RentRollImporter.import(valid_file_path)
      }.to output(/Import succeeded./).to_stdout
      expect(RentRollImporter.import(valid_file_path)).to be true
    end

    it 'handles an empty file path correctly' do
      expect {
        RentRollImporter.import('')
      }.to output("Please provide a valid CSV file path.\n").to_stdout
      expect(RentRollImporter.import('')).to be false
    end
  end
end
