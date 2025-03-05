class LeaseCreator
  def self.create(unit, tenant, move_in_date, move_out_date)
    return unless unit && tenant && move_in_date.present?

    Lease.create(unit: unit, tenant: tenant, move_in: move_in_date, move_out: move_out_date)
  end
end
