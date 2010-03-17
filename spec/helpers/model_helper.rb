require 'helpers/node_helper'
module ModelHelper
    include NodeHelper
    private

    def stub_model(options={})
      node = Puppet::Node
      node.stubs(options)
      node
    end
    alias :stub_model_class :stub_model

    def stub_model_instance(options={})
      stub_node(options)
    end
end
