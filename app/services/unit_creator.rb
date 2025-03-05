class UnitCreator
  def self.find_or_create(unit_number, floor_plan)
    Unit.find_or_create_by(unit_number: unit_number) do |u|
      u.floor_plan = floor_plan
    end
  end
end
