module IndirectionHelper
    def stub_indirection(options={})
        name = options.delete(:name) || :name
        model = options.delete(:model) || :model

        if indirection = Puppet::Indirector::Indirection.instance(name)
          indirection.delete
        end

        indirection = Puppet::Indirector::Indirection.new(model, name)
        indirection.stubs(options)
        indirection
    end
end
