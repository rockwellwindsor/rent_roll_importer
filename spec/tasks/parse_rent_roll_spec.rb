require 'rails_helper'
require 'rake'

RSpec.describe 'csv:import', type: :task do
 before do
    load Rails.root.join("lib/tasks/parse_rent_roll.rake")
    Rake::Task.define_task(:environment)
  end


  describe 'import task' do
    it 'prints an error message when the file does not exist' do
      expect {
        Rake::Task['csv:import'].invoke(FILE: 'non_existent_file.csv')
      }.to output("Please provide a valid CSV file path using FILE=your_file_path.csv\n").to_stdout
    end
  end
end
