require 'helper'

class Rails
  def self.root
    ''
  end
end

class TestController
  include EtagFor

  attr_accessor :view_context_mock
  def view_context
    @view_context_mock
  end
end

describe EtagFor do

  it "must convert file list to list of digests" do
    file_list = [ "file_1", "file_2" ]
    
    File.stub :read, "12345678" do
      digests = TestController.new.send(:digests_of, file_list)
      digests.must_be_instance_of Array
      digests.size.must_equal 2
    end
  end

  it "must lookup stylesheet path if stylesheet given" do
    view_context = MiniTest::Mock.new
    view_context.expect :stylesheet_path, 'css-name', [ 'application' ]

    controller = TestController.new
    controller.view_context_mock = view_context

    controller.send(:css_path, "application").must_equal "css-name"
  end

  it "must not lookup stylesheet path if no stylesheet given" do
    TestController.new.send(:css_path, "").must_be_nil
  end

  it "must lookup javascript path if javascript given" do
    view_context = MiniTest::Mock.new
    view_context.expect :javascript_path, 'js-name', [ 'application' ]

    controller = TestController.new
    controller.view_context_mock = view_context

    controller.send(:js_path, "application").must_equal "js-name"
  end

  it "must not lookup javascript path if no javascript given" do
    TestController.new.send(:js_path, "").must_be_nil
  end

  it "must return array from etag_for with single item" do
    item = MiniTest::Mock.new
    item.expect :to_param, "foo"

    TestController.new.etag_for(item, :css => "", :js => "").must_equal [ item, nil, nil ]
  end

  it "must return array from etag_for with many items" do
    item_1 = MiniTest::Mock.new
    item_1.expect :to_param, "foo"

    item_2 = MiniTest::Mock.new
    item_2.expect :to_param, "bar"

    TestController.new.etag_for( [ item_1, item_2 ], :css => "", :js => "").must_equal [ item_1, item_2, nil, nil ]
  end
end

