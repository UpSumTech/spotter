## Spotter

Allows you to easily add observers to your objects.
You can define several observers for a single class and add specific
observers for specific methods.

[![Gem Version](https://badge.fury.io/rb/spotter.png)](http://badge.fury.io/rb/spotter)
[![Build Status](https://travis-ci.org/sumanmukherjee03/spotter.png)](https://travis-ci.org/sumanmukherjee03/spotter)
[![Code Climate](https://codeclimate.com/github/sumanmukherjee03/spotter.png)](https://codeclimate.com/github/sumanmukherjee03/spotter)
[![Dependency Status](https://gemnasium.com/sumanmukherjee03/spotter.png)](https://gemnasium.com/sumanmukherjee03/spotter)
[![Coverage Status](https://coveralls.io/repos/sumanmukherjee03/spotter/badge.png)](https://coveralls.io/r/sumanmukherjee03/spotter)

## Installation

Add this line to your application's Gemfile:

    gem 'spotter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spotter

## Usage
Lets say there is a class called SuperHero.
Assume we need to observe the object with an observer Foo when it is saved.
Assume we need to observe the object with an observer Bar when it is reset.

In the SuperHero class, you need to include the module Spotter.
You need to register your observers using the ```register_observers``` class method.
You also need to specify the methods being observed using the ```methods_observed``` class method.
And lastly, you need to invoke ```run_observers``` in the method where you want to trigger the observers.
```ruby
class SuperHero
  
  include Spotter

  register_observers :foo, :bar
  methods_observed :build, :destroy

  attr_accessor :super_hero

  def initialize
    @super_hero = 'Ironman'
  end

  def build
    run_observers(:for => :save, :with => :foo) do
      self.super_hero += ' - Tony Stark'
    end
  end

  def destroy
    run_observers(:for => :reset, :with => :bar) do
      self.super_hero = self.super_hero.split('-').first.strip
    end
  end
end
```
While calling the method ```run_observers```, you need to specify 2 options - :for and :with.
The :for option specifies the method for which the observer is to be called.
The :with option specifies the observers which need to be triggered.
You also need to pass it a block, which contains the actual body of the method.
The run_observers method attaches the observer to the object and then triggers them.

As the example above depicts, you can have multiple observers - :foo, :bar.
Also, you can have multiple methods being observed with different observers.

Now we need to implement our observer.
The observer must be within the namespace of the class.
So, the observers named named Spottertest::Foo SuperHero::Bar and not just Foo or Bar.
```ruby
class SuperHero::Foo
  attr_accessor :obj

  def initialize(obj)
    @obj = obj
    obj.add_observer(self, :notify_paparrazzi)
  end

  def notify_paparrazzi
    Notifier.inform_paparazzi(obj) # Send an email to paparazzi
  end
end

class SuperHero::Bar
  attr_accessor :obj

  def initialize(obj)
    @obj = obj
    obj.add_observer(self, :notify_the_mandarin)
  end

  def notify_the_mandarin
    Notifier.inform_mandarin(obj) # Send an email to mandarin
  end
end
```
The initialize method of the observer must accept the object it is observing.
It must then add itself to the object being observed.
By default the method ```update``` is called when notify_observers is invoked.
However, while adding the observer you can specify which method is to be invoked.

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
