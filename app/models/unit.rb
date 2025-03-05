class Unit < ApplicationRecord
  enum :floor_plan, {:studio=>0, :suite=>1, :two_bedroom=>2, :three_bedroom=>3}

  has_many :leases, dependent: :destroy
  has_many :tenants, through: :leases

  validates :unit_number, presence: true
  validates :floor_plan, presence: true
end
