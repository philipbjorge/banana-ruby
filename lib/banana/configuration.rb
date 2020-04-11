module Banana::Configuration
  class Configuration
    attr_accessor :output, # IO to write output messages.
                  :color, # Whether to colorize output or not
                  :base_url,
                  :api_key

    def initialize
      @output = $stdout
      @color = true
      @base_url = "https://banana.philipbjorge.com/"
    end

    def color?
      color == true
    end
  end
  
  def config
    @config ||= Configuration.new
  end

  def configure
    yield config
  end
end