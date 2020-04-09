module Banana::Frameworks
  def rspec?
    defined?(RSpec::Core)
  end

  def minitest?
    defined?(Minitest)
  end
end