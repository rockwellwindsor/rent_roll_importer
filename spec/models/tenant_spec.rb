require 'rails_helper'

RSpec.describe Tenant, type: :model do
  subject { described_class.new }

  it 'requires a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is valid with all required attributes' do
    subject.name = 'John Doe'
    expect(subject).to be_valid
  end
end
