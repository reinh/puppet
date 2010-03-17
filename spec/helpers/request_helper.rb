module RequestHelper
  # RH:FIXME why do we stub name even though Request objects don't have a name
  # method?
  def stub_request(options)
    name = options[:name] || 'name'
    method = options.delete(:method) || 'find'
    key = options.delete(:key) || 'key'

    request = Puppet::Indirector::Request.new(name, method, key)
    request.stubs(options)
    request
  end
end
