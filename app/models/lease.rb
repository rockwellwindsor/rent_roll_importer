class Lease < ApplicationRecord
  belongs_to :unit
  belongs_to :tenant

  validates :move_in, presence: true
end
