module TransactionHelper
  include CatalogHelper
  def stub_transaction(catalog=stub_catalog, options={})
    transaction = Puppet::Transaction.new(catalog)
    transaction.stubs(options) unless options.empty?
    transaction
  end
end
