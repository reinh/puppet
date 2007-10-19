#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../../spec_helper'

require 'puppet/file_serving/content'

describe Puppet::FileServing::Content do
    it "should indirect file_content" do
        Puppet::FileServing::Content.indirection.name.should == :file_content
    end

    it "should should include the TerminusSelector module in its indirection" do
        Puppet::FileServing::Content.indirection.metaclass.included_modules.should include(Puppet::FileServing::TerminusSelector)
    end
end

describe Puppet::FileServing::Content, " when initializing" do
    before do
        @path = "/my/file"
    end

    it "should accept a file path" do
        FileTest.expects(:exists?).with(@path).returns(true)
        Puppet::FileServing::Content.new(@path).path.should == @path
    end

    it "should require a fully qualified file path" do
        proc { Puppet::FileServing::Content.new("unqualified") }.should raise_error(ArgumentError)
    end

    it "should require the path to exist" do
        FileTest.expects(:exists?).with(@path).returns(false)
        proc { Puppet::FileServing::Content.new(@path) }.should raise_error(ArgumentError)
    end

    it "should not stat the file" do
        FileTest.expects(:exists?).with(@path).returns(true)
        File.expects(:read).with(@path).never
        Puppet::FileServing::Content.new(@path)
    end
end

describe Puppet::FileServing::Content, " when converting to yaml" do
    before do
        @path = "/my/file"
        FileTest.expects(:exists?).with(@path).returns(true)
        @content = Puppet::FileServing::Content.new(@path)
    end

    it "should return the file contents" do
        File.expects(:read).with(@path).returns("mycontent")
        @content.to_yaml.should == "mycontent"
    end
end

describe Puppet::FileServing::Content, " when converting from yaml" do
    # LAK:FIXME This isn't in the right place, but we need some kind of
    # control somewhere that requires that all REST connections only pull
    # from the file-server, thus guaranteeing they go through our authorization
    # hook.
    it "should set the URI scheme to 'puppetmounts'" do
        pending "We need to figure out where this should be"
    end
end