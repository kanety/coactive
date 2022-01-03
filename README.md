# Coactive

Make classes coactive.

## Dependencies

* ruby 2.3+
* activesupport 5.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coactive'
```

Then execute:

    $ bundle

## Usage

### Coactors

Include `Coactive::Base` to your base class:

```ruby
class Base
  include Coactive::Base
end
```

Define coactive classes that inherit your base class:

```ruby
class A < Base
end

class B < Base
end

class C < Base
  coact A
  coact B
end
```

You can lookup coactors as follows:

```ruby
C.new.coactors
# => [A, B]
```

#### Named coactors

You can also define coactive classes by using specific name:

```ruby
class A < Base
  coaction :coactive_name
end

class B < Base
  coaction :coactive_name
end

class C < Base
  coact :coactive_name
end

C.new.coactors
# => [A, B]
```

Coactors are looked up from descendants of your base class.
Note that the coactors are unordered.

In development mode of rails, it is necessary to load source files for looking up classes having specific coaction.
You can configure source file locations by `load_paths` as the following example:

```ruby
class Base
  include Coactive::Base

  configure_coactive do |config|
    config.load_paths = ['app/coactors']
  end
end
```

#### Object-based coactors

You can also define coactive classes by using object:

```ruby
class ItemA
end

class ItemB
end

class Base::ItemA < Base
end

class Base::ItemB < Base
end

class Base::C < Base
  coact ItemA
  coact ItemB
end

Base::C.new.coactors
#=> [Base::ItemA, Base::ItemB]
```

Coactors are looked up from the namespace corresponding with caller classes.

You can also looked up coactors corresponding with superclass of object.
You can configure this feature by `lookup_superclass_for_object` and `lookup_superclass_until`:

```ruby
class Base
  include Coactive::Base

  configure_coactive do |config|
    config.lookup_superclass_for_object = true
    config.lookup_superclass_until = ['ActiveRecord::Base', 'ActiveModel::Base']
  end
end
```

#### Dynamic coactors

You can also dynamically lookup coactors by using block or instance method:

```ruby
class A < Base
end

class B < Base
end

class C < Base
  # use block
  coact do
    if @condition == 'A'
      A
    else
      B
    end
  end

  def initialize(condition)
    @condition = condition
  end
end

C.new('A').coactors
#=> [A]
C.new('B').coactors
#=> [B]

class D < Base
  # use method
  coact :coactivate_with_condition

  def initialize(condition)
    @condition = condition
  end

  def coactivate_with_condition
    if @condition == 'A'
      A
    else
      B
    end
  end
end

D.new('A').coactors
#=> [A]
D.new('B').coactors
#=> [B]
```

#### Nested coactors

You can define nested coactors. For example:

```ruby
class NestedA < Base
end

class NestedB < Base
end

class A < Base
  coact NestedA
end

class B < Base
  coact NestedB
end

class C < Base
  coact A
  coact B
end

C.new.coactors.map { |klass| [klass] + klass.new.coactors }.flatten
#=> [A, NestedA, B, NestedB]
```

### Context

You can define variables used in a coactor as a context by including `Coactive::Initializer`.
The variables are stored in `context` as follows:

```ruby
class Base
  include Coactive::Base
  include Coactive::Initializer
end

class A < Base
  context :input
end

coactor = A.new(input: 'something')
coactor.context.input
#=> something
```

#### Required context

You can also define required context as follows:

```ruby
class A < Base
  context :input, required: true
end

A.new
#=> Coactive::MissingContextError (missing required context: input)
```

#### Default value

You can also define default value as follows:

```ruby
class A < Base
  context :input, default: 'something'
end

coactor = A.new
coactor.context.input
#=> something
```

### Contextualizer

You can copy context variables to a coactor by calling `contextualize`:

```ruby
class Base
  include Coactive::Base
  include Coactive::Initializer
  include Coactive::Contextualizer
end

class A < Base
  context :input
end

coactor = A.new(input: 'something')
coactor.contextualize
coactor.input
#=> something
coactor.instance_variable_get(:@input)
#=> something
```

#### Output

You can also set context when finished `contextualize` block:

```ruby
class A < Base
  context :result, output: true

  def call
    @result = 'something'
  end
end

coactor = A.new
coactor.contextualize { coactor.call }
coactor.context.result
#=> something
```

#### Output return value

You can also set context from return value of `contextualize` block:

```ruby
class A < Base
  context :result, output: :return
end

coactor = A.new
coactor.contextualize { 'return value' }
coactor.context.result
#=> return value
```

### Configuration

You can set configurations in your base class as follows:

```ruby
class Base
  include Coactive::Base

  configure_coactive do |config|
    # path to source files for coactors
    config.load_paths = ['app/coactors']
    # suffix of class that inherits base class
    config.class_suffix = 'Coactor'
    # cache coactors in memory
    config.use_cache = true
    # lookup coactors corresponding with superclass of object
    config.lookup_superclass_for_object = true
    # lookup coactors until superclass is not in the list
    config.lookup_superclass_until = ['ActiveRecord::Base', 'ActiveModel::Base']
  end
end
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/coactive.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
