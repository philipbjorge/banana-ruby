require_relative '../banana'

module Minitest
  class BananaReporter < AbstractReporter
    def initialize(options)
      @test_times = {}
    end

    def start
      Banana.tracker.record_suite_stats(started_at: Banana.now)
    end

    def prerecord klass, name
      @test_times["#{klass}##{name}"] = {
          now: Banana.now,
          clock: Banana.clock_time
      }
    end

    def record(result)
      Banana.tracker.record_test_stats(
          started_at: @test_times["#{result.klass}##{result.name}"][:now],
          ended_at: Banana.now,
          duration_s: Banana.clock_time - @test_times["#{result.klass}##{result.name}"][:clock],
          failure: result.failures.first,
          status: to_status(result),
          file_path: result.source_location[0],
          line_number: result.source_location[1],
          fingerprint: "#{result.klass}##{result.name}"
      )
    end

    def report
      Banana.tracker.record_suite_stats(ended_at: Banana.now, duration_s: Banana.now - Banana.tracker.suite_started_at)
      Banana.tracker.report
    end

    private
    def to_status(result)
      return :passed  if result.passed?
      return :failed  if result.error?
      return :skipped if result.skipped?
    end
  end

  def self.plugin_banana_options(opts, options)
  end

  def self.plugin_banana_init(options)
    self.reporter << BananaReporter.new(options)
  end
end