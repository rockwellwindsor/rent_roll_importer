require 'rails_helper'

RSpec.describe UnitCreator, type: :service do
	let(:unit_number) { '23' }
	let(:floor_plan) { 'two_bedroom' }

  describe '.create' do
    context 'when provided valid attributes' do
    	context 'that are not already present' do
	      it 'creates a unit' do
	        expect {
	          UnitCreator.find_or_create(unit_number, floor_plan)
	        }.to change { Unit.count }.by(1)
	      end
	    end

    	context 'that are already present' do
    		before do
    			Unit.create(unit_number: '23', floor_plan: :two_bedroom)
    		end
    		it 'does not create a unit' do
	        expect {
	          UnitCreator.find_or_create(unit_number, floor_plan)
	        }.not_to change { Unit.count }
	      end
    	end
    end
  end
end
