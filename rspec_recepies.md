###Working with rspec 

```

```

### How to run tests with rspec
```
rspec path/to/test/file
```
You can make the test output more verbose by using this command

```
rspec path/to/test/file --format documentation
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
##### equal matcher
the equal matcher test for identical objects in memory

Note: expect does not support == matcher 

##### Depricated matchers
The 'have' matchers was deprecated a long time a go

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

###Pending tests
There are three ways to make tests pend
* leave the body of the it empty
Example 

```
describe Zombie do 
    it "is named Ash" do
        # leave the body of it empty
end 
```

* add x before it
Example 
```
describe Zombie do 
    xit "is named Ash" do # xit makes this pend
        zombie = Zombie.new 
        expect(zombie.name).to eq("Ash")
    end 
end 
```

* Use the pending key word
Example 

```
describe Zombie do 
    it "is named Ash" do
        pending
        zombie = Zombie.new 
        expect(zombie.name).to eq("Ash")
    end 
end
```
###using #method name in the "it" block
Example

```
describe Book do
    before :each do
        @book = Book.new "Title", "Author", :category
    end

    it "#new" do
    end 
end
```
We might want to use #method name because the output of the test will be something like this

Book#new which is ClassName#methodName. This is a ruby convention for instance methods

###[Before blocks](http://www.rubydoc.info/gems/rspec-core/RSpec%2FCore%2FHooks%3Abefore) 
Module: RSpec::Core::Hooks
before is often used to perform actions common across tests. There are three scopes that you can use with before
** :each or :example 
** :all or :context
** :suite

before :each means run the block before each test. 
before :all means run the block once before all the tests

###[describe vs. context in rspec](http://lmws.net/describe-vs-context-in-rspec) 
According to the [rspec source code](https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/example_group.rb), “context” is just an alias method of “describe”, meaning that there is no functional difference between these two methods. However, there is a contextual difference that’ll help to make your tests more understandable by using both of them.

The purpose of “describe” is to wrap a set of tests against one functionality while “context” is to wrap a set of tests against one functionality under the same state. Here’s an example

```
describe "launch the rocket" do
  before(:each) do
    #prepare a rocket for all of the tests
    @rocket = Rocket.new
  end
 
  context "all ready" do
    before(:each) do
      #under the state of ready
      @rocket.ready = true
    end
 
    it "launch the rocket" do
      @rocket.launch().should be_true
    end
  end
 
  context "not ready" do
    before(:each) do
      #under the state of NOT ready
      @rocket.ready = false
    end
 
    it "does not launch the rocket" do
      @rocket.launch().should be_false
    end
  end
end
```

###Shared_examples block
Shared examples make testing compositions of objects much easier. This has been nicely explained in [this blog](http://modocache.io/shared-examples-in-rspec)

###let() and let!()
This function in rspec is suppose to define a memoized helper method. In computing, memoization is an optimization technique used primarily to speed up computer programs by storing the results of expensive function calls and returning the cached result when the same inputs occur again.

Use the let define a memoized helper method

```
$count = 0
describe "let" do
  let(:count) { $count += 1 }

  it "memoizes the value" do
    count.should == 1
    count.should == 1
  end

  it "is not cached across examples" do
    count.should == 2
  end
end
```

Use the let! to define a memoized helper method that is called in a before hook
```
$count = 0
describe "let!" do
  invocation_order = []

  let!(:count) do
    invocation_order << :let!
    $count += 1
  end

  it "calls the helper method in a before hook" do
    invocation_order << :example
    expect(invocation_order).to eq([:let!, :example])
    expect(count).to eq(1)
  end

  it "should just test" do
    invocation_order << :example2
    expect(invocation_order).to eq([:let!, :example, :let!,:example2])
    expect(count).to eq(2)
  end
end
```

