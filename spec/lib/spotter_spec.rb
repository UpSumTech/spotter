require 'spec_helper'

describe Spotter do
  class SpotterTest
    class Foo
      attr_accessor :obj

      def initialize(obj)
        @obj = obj
        obj.add_observer(self)
      end

      def update
        obj.bar += 'observer'
      end
    end

    include Spotter

    register_observers :foo

    attr_accessor :bar

    def initialize
      @bar = 'hola'
    end

    def save
      attach_observers(:foo)
      self.bar += 'test'
      changed
      notify_observers
    end
  end

  subject { SpotterTest.new }

  describe "observes the changes in the object it is observing" do
    it "updates the object" do
      subject.save
      subject.bar.should eq('holatestobserver')
    end
  end

  it "throws an error when the observer is not found" do
    expect { subject.attach_observer(:baz) }.to raise_exception("baz is not registered as an observer")
  end

  it "throws an error when registering an observer for which a class does not exist" do
    expect { SpotterTest.register_observer(:baz) }.to raise_exception(ArgumentError, "baz is not valid. If you have an observer SpotterTest::FooBar, pass :foo_bar")
  end
end

