# rafini

## DESCRIPTION:

Just a collection of useful refinements.

## SYNOPSIS:

### using Rafini::Array

    # joins
    ['a','b','c','d','e','f'].joins('-','-',' '){':'} #=> "a-b-c d:e:f"

    # per
    h={}
    ['a','b','c'].per(['A','B','C']){|l,u| h[l]=u}
    h #=> {'a'=>'A','b'=>'B','c'=>'C'}

    # which
    ['dog','cat','bunny'].which{|a|a=~/c/} #=> "cat"

    # is
    [:a,:b,:c].is(true) #=> {a: true, b: true, c: true}

### using Rafini::Exception

    # $!.puts
    begin
      raise 'Ugly Message'
    rescue RuntimeError
      $!.puts 'Nice Message'
    end

    # Rafini.bang!
    value = Rafini.bang!('Nice Message') do
      raise 'Ugly Message'
    end
    value #=> return value of block or error object

    # Rafini.thread_bang!
    Rafini.thread_bang!('Nice Message') do
      # this is in a thread
      raise 'Ugly Message'
    end

### using Rafini::Hash

    # to_struc
    struct = {a:'A',b:'C',c:'C'}.to_struct
    struct.a #=> 'A'

    # modify
    {a:'A',b:'B'}.modify({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {a:'A',b:'X',c:'Y',d:'D'}

    # supplement
    {a:'A',b:'B'}.supplement({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {a:'A',b:'B',c:'C',d:'D'}

    # amend
    {a:'A',b:'B'}.amend({b:'X',c:'C'},{c:'Y',d:'D'}) #=> {a:'A',b:'X'}

    # maps
    {a:'A',b:'B',c:'C',c:'D'}.maps(:c,:a,:b) #=> ['C','A','B']

### using Rafini::Integer

    # odometer
    123.odometer(10,10) #=> [3,2,1]
    30.odometer(2,3,5) #=> [0,0,0,1]

### using Rafini::Odometers

    # sec2time
    12501.sec2time.to_s #=> "3 hours and 28 minutes"

    # illion
    3_512_325.illion.to_s #=> "3.51M"

### using Rafini::String

    # camelize
    'a_camel_kick'.camelize #=> "ACamelKick"

    # semantic
    '1.2.3'.semantic(0..1) #=> '1.2'

### Rafini::Empty

    STRING, ARRAY, HASH = ''.frozen, [].frozen, {}.frozen

## INSTALL:

    $ gem install rafini

## LICENSE:

(The MIT License)

Copyright (c) 2020 carlosjhr64

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
