module Rafini
  module Exception
    refine ::Exception do
      # bang! outputs to standard error what went bang!
      # Message is what you normally want to see.
      # The exeption message is also shown if in verbose mode.
      # Bactrace is shown if in debug mode.
      def puts(message=nil)
        unless $VERBOSE.nil? then
          $stderr.puts message if message
          $stderr.puts self.message if $VERBOSE or !message
          $stderr.puts self.backtrace.to_s if $DEBUG
        end
      end
    end
  end
end

# Module version of bang!
using Rafini::Exception
def Rafini.bang!(message=nil, bang=Exception, &block)
  value = nil
  begin
    value = block.call
  rescue bang => value
    value.puts(message)
  end
  return value
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
def Rafini.thread_bang!(header=nil, bang=Exception, &block)
  Thread.new{Rafini.bang!(header, bang, &block)}
end
