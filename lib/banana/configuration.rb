module Banana::Configuration
  class Configuration
    attr_accessor :output, # IO to write output messages.
                  :color # Whether to colorize output or not

    def initialize
      @output = $stdout
      @color = true
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