module CatalogHelper
  def stub_catalog(options={})
    name = options.delete(name)

    catalog = Puppet::Resource::Catalog.new(name)
    catalog.stubs(options) unless options.empty?
    catalog
  end
end
