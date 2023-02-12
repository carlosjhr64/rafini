module Rafini
  module Exception
    refine ::Exception do
      # $!.puts outputs to standard error what went bang!
      # The given message is what you normally want to see.
      # The exeption message is also shown if in verbose mode.
      # Backtrace is shown if in debug mode.
      #   begin
      #     raise 'Ugly message'
      #   rescue RuntimeError
      #     # exact output depends on $VERBOSE and $DEBUG
      #     $!.puts('Nice message')
      #   end
      def puts(msg=nil)
        unless $VERBOSE.nil?
          warn msg if msg
          warn message if $VERBOSE || !msg
          warn backtrace.to_s if $DEBUG
        end
      end
    end
  end
end

using Rafini::Exception

# Module version of puts bang!
# Returns either the value or error of the block.
#   value = Rafini.bang!('Ooops! Not perfect?') do
#     # Perfect code here...
#   end
def Rafini.bang!(msg=nil, bang=Exception, &block)
  e = nil
  begin
    e = block.call
  rescue bang => e
    e.puts(msg)
  end
  e
end

# The Thread wrapped version of bang!
# I often do
#  Thread.new do
#    begin
#      ... stuff ..
#    rescue Exception
#      puts 'blah blah...'
#      puts $!.message if $VERBOSE
#      puts $!.backtrace if $DEBUG
#    end
#  end
# With the following below, I'll be able to say
# Rafini.thread_bang!('blah blah...'){ ...stuff... }
def Rafini.thread_bang!(header=nil, bang=Exception, &)
  Thread.new{Rafini.bang!(header, bang, &)}
end
