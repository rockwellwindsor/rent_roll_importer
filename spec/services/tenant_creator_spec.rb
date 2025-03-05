require 'rails_helper'

RSpec.describe TenentCreator, type: :service do
	let(:name) { 'Test User' }
  describe '.create' do
    context 'when provided valid attributes' do
      it 'creates a tenent' do
        expect {
          TenentCreator.create(name)
        }.to change { Tenent.count }.by(1)
      end
    end
     context 'when name is not provided' do
      it 'does not creates a tenent' do
        expect {
          TenentCreator.create(nil)
        }.not_to change { Tenent.count }
      end
    end
  end
end
