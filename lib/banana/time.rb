module Banana::Time
  # Returns the current process time
  if defined? Process::CLOCK_MONOTONIC # :nodoc:
    def clock_time
      Process.clock_gettime Process::CLOCK_MONOTONIC
    end
  else
    def clock_time
      now.to_f
    end
  end

  def now
    ::Time.method(:now).call # TODO: Does this work w/ Timecop?
  end
end