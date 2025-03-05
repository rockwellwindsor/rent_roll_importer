class RentRollProcessor
  def self.process(file_path)
    parsed_data = CSV.read(file_path, headers: true)

    parsed_data.each do |data|
      unit = UnitCreator.find_or_create(data[0], data[1])
      tenant = TenantCreator.create(data[2])

      LeaseCreator.create(unit, tenant, data[3], data[4])
    end
  end
end
