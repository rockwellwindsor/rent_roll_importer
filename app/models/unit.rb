class Unit < ApplicationRecord
  enum :floor_plan, {:studio=>0, :suite=>1, :two_bedroom=>2, :three_bedroom=>3}

  validates :unit_number, presence: true
  validates :floor_plan, presence: true
end
