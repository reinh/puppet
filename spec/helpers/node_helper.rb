module NodeHelper
  def stub_node(options)
    name = options.delete(:name) || 'node'
    node = Puppet::Node.new(name)
    node.stubs(options)
    node
  end
end
