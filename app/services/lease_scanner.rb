class LeaseScanner
  def self.leases(on_date)
    Lease.where("move_in <= ? AND move_out >= ?", on_date, on_date)
  end

  def self.vacant_units(on_date)
    occupied_unit_ids = Lease.where("move_in <= ? AND move_out >= ?", on_date, on_date).pluck(:unit_id)
    Unit.where.not(id: occupied_unit_ids)
  end

  def self.generate_report(on_date)
    lease_output = ""
    leases = leases(on_date)

    if leases.any?
      lease_output << "\n#{leases.count} Leases on #{on_date}:\n"
      leases.each do |lease|
        lease_output << "Unit #{lease.unit.unit_number}, Tenant: #{lease.tenant.name}, Move In: #{lease.move_in}, " \
                        "Move Out: #{lease.move_out}\n"
      end
    else
      lease_output << "No leases active on #{on_date}.\n"
    end

    vacant_output = ""
    vacant_units = vacant_units(on_date)

    if vacant_units.any?
      vacant_output << "\n#{vacant_units.count} Vacant units on #{on_date}:\n"
      vacant_units.each do |unit|
        vacant_output << "Unit #{unit.unit_number}, Floor Plan: #{unit.floor_plan}\n"
      end
    else
      vacant_output << "No vacant units on #{on_date}.\n"
    end

    puts lease_output
    puts vacant_output
    [lease_output, vacant_output]
  end
end
