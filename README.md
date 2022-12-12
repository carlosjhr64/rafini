# Rafini

* [VERSION 3.1.221212](https://github.com/carlosjhr64/rafini/releases)
* [github](https://github.com/carlosjhr64/rafini)
* [rubygems](https://rubygems.org/gems/rafini)

## DESCRIPTION:

Just a collection of useful refinements.

## INSTALL:
```shell
$ gem install rafini
```
## SYNOPSIS:
```ruby
require 'rafini'
```
### include Rafini::Empty
```ruby
include Rafini::Empty

s0 #=> ""
a0 #=> []
h0 #=> {}
[s0,a0,h0].all?(&:frozen?) #=> true
```
### using Rafini::Array
```ruby
using Rafini::Array

# joins
['Y','M','D','h','m','s'].joins('-','-',' '){':'}
#=> "Y-M-D h:m:s"
[1,9,2,8,3,7,4,6,5,5].joins{|a,b|a>b ? '>': a<b ? '<': '='}
#=> "1<9>2<8>3<7>4<6>5=5"

# is
[:a,:b,:c].is(true) #=> {:a=>true, :b=>true, :c=>true}
```
### using Rafini::Hash
```ruby
using Rafini::Hash

# to_struc
struct = {a:'A',b:'C',c:'C'}.to_struct{ def ok = "OK" }
struct    #=> #<struct a="A", b="C", c="C">
struct.a  #=> "A"
struct.ok #=> "OK"

# supplement
{a:'A',b:'B'}.supplement({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {:a=>"A", :b=>"B", :c=>"C", :d=>"D"}

# amend
{a:'A',b:'B'}.amend({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {:a=>"A", :b=>"X"}
```
### using Rafini::Integer
```ruby
using Rafini::Integer

# odometer
123.odometer(10,10) #=> [3, 2, 1]
30.odometer(2,3,5)  #=> [0, 0, 0, 1]
```
### using Rafini::String
```ruby
using Rafini::String

# camelize
'a_camel_kick'.camelize #=> "ACamelKick"

# semantic
'1.2.3'.semantic(0..1) #=> "1.2"
```
### using Rafini::Exception
```ruby
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
thread = Rafini.thread_bang!('Nice Message') do
  # this is in a thread
  raise 'Ugly Message' # outputs as $!.puts 'Nice Message'
end
# The returned value joined from the thread
# will not re-raise the error(but gives the error).
thread.value.class #=> RuntimeError
```
### using Rafini::Odometers
```ruby
using Rafini::Odometers

# sec2time
12501.sec2time.to_s #=> "3 hours and 28 minutes"

# illion
3_512_325.illion.to_s #=> "3.51M"
```
### using Rafini::Requires
```ruby
using Rafini::Requires

requires'
ruby   ~>3.0
rafini ~>3.1
json   ~>2.0' #=> ["json"]
```
## LICENSE:

(The MIT License)

Copyright (c) 2022 CarlosJHR64

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
