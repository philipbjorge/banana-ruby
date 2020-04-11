require "banana/version"
require "banana/logging"
require "banana/configuration"
require "banana/frameworks"
require "banana/time"
require "banana/tracker"
require "banana/bootstrap"
require "banana/client"

module Banana
  class << self 
    include Logging
    include Configuration
    include Frameworks
    include Time
    include Bootstrap
    include Client
    def tracker
      Tracker.instance
    end
    def client
      Client.instance
    end
  end
end

Banana.bootstrap!