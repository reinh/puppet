
#!/usr/bin/env ruby

Dir.chdir(File.dirname(__FILE__)) { (s = lambda { |f| File.exist?(f) ? require(f) : Dir.chdir("..") { s.call(f) } }).call("spec/spec_helper.rb") }

checksum_class = Puppet::Type.type(:file).propertybyname(:checksum)

describe checksum_class do
    describe "#managed?" do
        before do
            @property = checksum_class.new(:resource => stub('resource'))
        end

        it { @property.managed?.should be_false }
    end
end
