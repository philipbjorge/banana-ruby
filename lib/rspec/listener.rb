class Banana::RSpecListener
  def self.instrument!
    RSpec.configure do |config|
      config.reporter.register_listener(Banana::RSpecListener.new, :start, :dump_summary)
    end
  end

  def start(_notification)
    Banana.tracker.record_suite_stats(started_at: ::RSpec::Core::Time.now)
  end

  def dump_summary(summary)
    Banana.tracker.record_suite_stats(ended_at: ::RSpec::Core::Time.now,
                                 load_time_s: summary.load_time,
                                 status: summary_to_status(summary))

    (summary.examples + summary.failed_examples + summary.pending_examples).each do |ex|
      er = ex.execution_result
      Banana.tracker.record_test_stats(started_at: er.started_at, ended_at: er.finished_at,
                                  failure: er.exception,
                                  duration_s: er.run_time, # TODO: Monotonic clock
                                  status: er.example_skipped? ? :skipped : er.status,
                                  file_path: ex.file_path,
                                  line_number: ex.metadata[:line_number],
                                  fingerprint: ex.full_description)
    end

    Banana.tracker.report
  end

  private
  def summary_to_status(summary)
    failed, passed, pending = summary.failed_examples.count, summary.examples.count, summary.pending_examples.count
    return :failed if (failed > 0)
    return :passed if (passed > 0 && (failed + pending) == 0)
    return :passed_with_pending if (passed > 0 && failed == 0)
    return :pending if pending > 0
    :missing if (failed + passed + pending) == 0
  end
end