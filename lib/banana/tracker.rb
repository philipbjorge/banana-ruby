require 'singleton'

class Banana::Tracker
  include Singleton

  def initialize
    super
    @suite_stats = {}
    @test_stats = []
    @client = Banana.client
  end

  def record_suite_stats(started_at: nil, ended_at: nil, load_time_s: nil, status: nil, duration_s: nil)
    @suite_stats.merge!({
                            started_at: started_at,
                            ended_at: ended_at,
                            load_time_s: load_time_s,
                            status: status,
                            duration_s: duration_s
                        }.compact)
  end

  def record_test_stats(started_at:, ended_at:, failure:, duration_s:, status:, file_path:, line_number:, fingerprint:)
    @test_stats << {
        started_at: started_at,
        ended_at: ended_at,
        failure: failure ? {
            klass: failure&.class&.name,
            message: failure&.message,
            backtrace: failure&.backtrace&.first(3)
        } : nil,
        duration_s: duration_s,
        status: status,
        file_path: file_path,
        line_number: line_number,
        fingerprint: fingerprint
    }
  end

  def report
    self.record_suite_stats(status: suite_status)
    
    puts "Recorded results at tpm.yaml"
  end

  def suite_started_at
    @suite_stats[:started_at]
    @client.upload_suite_results(@suite_stats.merge(executions: @test_stats))
  end
  
  private

  def suite_status
    return :failed if @test_stats.any? { |t| t[:status] == :failed } || @test_stats.count == 0
    return :passed if @test_stats.all? { |t| t[:status] == :passed }
    return :passed_with_pending if @test_stats.any? { |t| t[:status] == :skipped || t[:status] == :pending } && @test_stats.any? { |t| t[:status] == :passed }
    return :pending
  end
end