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
    methods_observed :save, :improper_save, :another_improper_save

    attr_accessor :bar

    def initialize
      @bar = 'hola'
    end

    def save
      run_observers(:for => :save, :with => :foo) do
        self.bar += 'test'
      end
    end

    def improper_save
      run_observers(:for => :improper_save) do
        self.bar += 'test'
      end
    end

    def another_improper_save
      run_observers(:with => :foo) do
        self.bar += 'test'
      end
    end

    def unobserved_save
      run_observers(:for => :unobserved_save, :with => :foo) do
        self.bar += 'test'
      end
    end
  end

  subject { SpotterTest.new }

  describe "observes the changes in the object it is observing" do
    it "updates the object" do
      subject.save
      subject.bar.should eq('holatestobserver')
    end
  end

  it "throws an error when you call run_observers without a option :with" do
    expect { subject.improper_save }.to raise_exception(ArgumentError, "Must have an option called :with")
  end

  it "throws an error when you call run_observers without a option :for" do
    expect { subject.another_improper_save }.to raise_exception(ArgumentError, "Must have an option called :for")
  end

  it "throws an error when you call run_observers with an option :for which represents a method that is not observed" do
    expect { subject.unobserved_save }.to raise_exception(ArgumentError, "Method is not being observed")
  end

  it "throws an error when the observer is not found" do
    expect { subject.attach_observer(:baz) }.to raise_exception("baz is not registered as an observer")
  end

  it "throws an error when registering an observer for which a class does not exist" do
    expect { SpotterTest.register_observer(:baz) }.to raise_exception(ArgumentError, "baz is not valid. If you have an observer SpotterTest::FooBar, pass :foo_bar")
  end
end

