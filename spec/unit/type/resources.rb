#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../../spec_helper'

resources = Puppet::Type.type(:resources)

# There are still plenty of tests to port over from test/.
describe resources do
    describe "#check(resource)" do
        before do
            @resources = Puppet::Type.type(:resources).new(:name => :host)
            @resource = mock('Resource')
        end

        it "should return the value of the checked method if the checked method exists" do
            checked_value = mock('Checked Value')
            @resources.expects(:host_check).with(@resource).returns(checked_value)

            @resources.check(@resource).should == checked_value
        end

        it "should return true if the checked method does not exist" do
            @resources.check(@resource).should == true
        end
    end

    describe "when initializing" do
        it "should fail if the specified resource type does not exist" do
            Puppet::Type.stubs(:type).with("Resources").returns resources
            Puppet::Type.expects(:type).with("nosuchtype").returns nil
            lambda { resources.new :name => "nosuchtype" }.should raise_error(Puppet::Error)
        end

        it "should not fail when the specified resource type exists" do
            lambda { resources.new :name => "file" }.should_not raise_error
        end

        it "should set its :resource_type attribute" do
            resources.new(:name => "file").resource_type.should == Puppet::Type.type(:file)
        end
    end
end
