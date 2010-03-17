module FactsHelper
  def stub_facts(options={})
    name = options.delete(name) || 'name'

    facts = Puppet::Node::Facts.new(name)
    facts.stubs(options)
    facts
  end
end
