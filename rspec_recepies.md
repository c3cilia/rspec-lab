###Working with rspec 

```

```
###Use the expect syntax and not the old should syntax
You can read all about that in [here](http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/)

lib/zombie.rb 

```
class Zombie
    attr_accessor :name, :brains 
    def initialize  
        @name = "Ash"
        @brains = 0
    end 

end
```

spec/lib/zombie_spec.rb
```
require 'spec_helper'
require 'zombie'

describe Zombie do 
    it "is named Ash" do
        zombie = Zombie.new 
        expect(zombie.name).to eq("Ash")
    end 
    
end
```

###Matchers 
rspec-expecations provides a number of useful Matchers we use to compose expectations. A Matcher is any object that responds to the following methods:

```
matches?(actual)
failure_message_for_should
```
These methods are also part of the matcher protocol, but are optional:

```
does_not_match?(actual)
failure_message_for_should_not
description #optional
```

#####Predicates
In addition to those Expression Matchers that are defined explicitly, RSpec will create custom Matchers on the fly for any arbitrary predicate, giving your specs a much more natural language feel.

A Ruby predicate is a method that ends with a “?” and returns true or false. Common examples are empty?, nil?, and instance_of?.

All you need to do is write should be_ followed by the predicate without the question mark, and RSpec will figure it out from there. For example:

```
[].should be_empty => [].empty? #passes
[].should_not be_empty => [].empty? #fails
```

In addtion to prefixing the predicate matchers with “be_”, you can also use “be_a_” and “be_an_”, making your specs read much more naturally:

```
"a string".should be_an_instance_of(String) =>"a string".instance_of?(String) #passes

3.should be_a_kind_of(Fixnum) => 3.kind_of?(Numeric) #passes
3.should be_a_kind_of(Numeric) => 3.kind_of?(Numeric) #passes
3.should be_an_instance_of(Fixnum) => 3.instance_of?(Fixnum) #passes
3.should_not be_instance_of(Numeric) => 3.instance_of?(Numeric) #fails
```

#####Testing predicates that you have defined in the class

Examples
spec/lib/zombie_spec.rb
```
require 'spec_helper'
require 'zombie'

describe Zombie do 
    it "is named Ash" do
        zombie = Zombie.new 
        expect(zombie.name).to eq("Ash")
    end 

    it "has no brains" do
        zombie = Zombie.new
        expect(zombie.brains).to be < 1
    end 

    it "is hungry" do 
        zombie = Zombie.new 
        expect(zombie).to be_hungry # testing the predicate hungry
    end 
    
end
```

lib/zombie.rb

```
class Zombie
    attr_accessor :name, :brains 
    def initialize  
        @name = "Ash"
        @brains = 0
    end 

    def hungry?
        true
    end 
end
```



