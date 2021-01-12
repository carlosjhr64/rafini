# rafini 3.0.210112

## DESCRIPTION:

Just a collection of useful refinements.

## SYNOPSIS:

### using Rafini::Array

```ruby
require 'rafini/array'
using Rafini::Array

# joins
['a','b','c','d','e','f'].joins('-','-',' '){':'}
#=> "a-b-c d:e:f"

# is
[:a,:b,:c].is(true)
#=> {:a=>true, :b=>true, :c=>true}
```

### using Rafini::Exception

```ruby
require 'rafini/exception'
using Rafini::Exception

# $!.puts
# Normally stderr.puts your "Nice" message.
# Additionally puts your "Ugly" message when $VERBOSE.
# Additionally puts backtrace when $DEBUG
# No output when $VERBOSE is nil.
begin
  raise 'Ugly Message'
rescue RuntimeError
  $!.puts 'Nice Message'
end

# Rafini.bang!
error = Rafini.bang!('Nice Message') do
  raise 'Ugly Message'
  # Outputs as $!.puts "Nice Message"
end
error.class #=> RuntimeError
error.to_s  #=> "Ugly Message"

# Rafini.thread_bang!
Rafini.thread_bang!('Nice Message') do
  # this is in a thread
  raise 'Ugly Message'
end
```

### using Rafini::Hash

```ruby
require 'rafini/hash'
using Rafini::Hash

# to_struc
struct = {a:'A',b:'C',c:'C'}.to_struct
struct   #=> #<struct a="A", b="C", c="C">
struct.a #=> "A"

# supplement
{a:'A',b:'B'}.supplement({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {:a=>"A", :b=>"B", :c=>"C", :d=>"D"}

# amend
{a:'A',b:'B'}.amend({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {:a=>"A", :b=>"X"}
```

### using Rafini::Integer

```ruby
require 'rafini/integer'
using Rafini::Integer

# odometer
123.odometer(10,10) #=> [3, 2, 1]
30.odometer(2,3,5)  #=> [0, 0, 0, 1]
```

### using Rafini::Odometers

```ruby
require 'rafini/odometers'
using Rafini::Odometers

# sec2time
12501.sec2time.to_s #=> "3 hours and 28 minutes"

# illion
3_512_325.illion.to_s #=> "3.51M"
```

### using Rafini::String

```ruby
require 'rafini/string'
using Rafini::String

# camelize
'a_camel_kick'.camelize #=> "ACamelKick"

# semantic
'1.2.3'.semantic(0..1) #=> "1.2"
```

### Rafini::Empty

```ruby
require 'rafini/empty'
Rafini::Empty::STRING       #=> ""
Rafini::Empty::ARRAY        #=> []
Rafini::Empty::HASH         #=> {}
Rafini::Empty::HASH.frozen? #=> true
```

## INSTALL:

```shell
$ gem install rafini
```

## LICENSE:

(The MIT License)

Copyright (c) 2021 carlosjhr64

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
