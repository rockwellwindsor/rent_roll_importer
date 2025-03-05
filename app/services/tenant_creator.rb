class TenantCreator
  def self.create(name)
    Tenant.create(name: name) if name.present?
  end
end
