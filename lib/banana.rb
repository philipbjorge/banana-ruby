require "banana/version"
require "banana/logging"
require "banana/configuration"
require "banana/frameworks"
require "banana/time"
require "banana/tracker"
require "banana/bootstrap"

module Banana
  class << self 
    include Logging
    include Configuration
    include Frameworks
    include Time
    include Bootstrap
    def tracker
      Tracker.instance
    end
  end
end

Banana.bootstrap!