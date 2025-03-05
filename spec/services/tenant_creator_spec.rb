require 'rails_helper'

RSpec.describe TenantCreator, type: :service do
	let(:name) { 'Test User' }
  describe '.create' do
    context 'when provided valid attributes' do
      it 'creates a tenent' do
        expect {
          TenantCreator.create(name)
        }.to change { Tenant.count }.by(1)
      end
    end
     context 'when name is not provided' do
      it 'does not creates a tenent' do
        expect {
          TenantCreator.create(nil)
        }.not_to change { Tenant.count }
      end
    end
  end
end
