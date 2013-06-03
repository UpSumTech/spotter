## Spotter

A gem that allows you to add observers to your classes easily.

## Build status

[![Build Status](https://travis-ci.org/sumanmukherjee03/spotter.png)](https://travis-ci.org/sumanmukherjee03/spotter)

## Installation

Add this line to your application's Gemfile:

    gem 'spotter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spotter

## Usage
Lets say there is a class called SpotterTest which needs to be observed by a class called Foo.
In the SpotterTest class, you need to include the module Spotter.
Then in every method where you want to trigger the observer, you need to add 3 lines.

Here's our SpotterTest class and lets say the save method triggers the observer foo.
```ruby
class SpotterTest
  
  include Spotter

  register_observers :foo

  attr_accessor :bar

  def initialize
    @bar = 'hola'
  end

  def save
    attach_observers(:foo) # attach the observer you wish to trigger. You can have multiple comma separated observers.
    self.bar += 'test'
    changed # Call this method to mark the object as changed
    notify_observers # Call this method to trigger the observers
  end
end
```

Now we need to implement our observer.
The observer must be within the namespace of the class.
So, the observer is named Spottertest::Foo and not just Foo.

```ruby
class SpotterTest::Foo
  attr_accessor :obj

  def initialize(obj)
    @obj = obj
    obj.add_observer(self)
  end

  def update
    obj.bar += 'observer'
  end
end
```

The initialize method must accept the instance of the class it is observing.
It must also add itself to the instance of the class being observed.
By default update is called when notify_observers is called from the class being observed.
However, if you want a different method to be triggered, you can pass the method name as a second argument to add_observer.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Copyright (c) 2013 Suman Mukherjee

MIT License

For more information on license, please look at LICENSE.txt
