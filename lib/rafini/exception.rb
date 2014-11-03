module Rafini
  module Exception
    refine ::Exception do
      # bang! outputs to standard error what went bang!
      # Message is what you normally want to see.
      # The exeption message is also shown if in verbose mode.
      # Bactrace is shown if in debug mode.
      def bang!(message=nil)
        unless $VERBOSE.nil? then
          $stderr.puts message if message
          $stderr.puts self.message if $VERBOSE or !message
          $stderr.puts self.backtrace.to_s if $DEBUG
        end
      end
    end
  end
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
def Rafini.thread_bang!(header=nil, &block)
  Thread.new{Rafini.bang!(header, &block)}
end

# Module version of bang!
using Rafini::Exception
def Rafini.bang!(message=nil, bang=Exception, &block)
  error = nil
  begin
    block.call
  rescue bang => error
    error.bang!(message)
  end
  return error
end
