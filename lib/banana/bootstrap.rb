module Banana::Bootstrap
  def bootstrap!
    bootstrap_rspec! if Banana.rspec?
    bootstrap_minitest! if Banana.minitest?
  end
  
  private
  def bootstrap_rspec!
    require_relative '../rspec/listener'
    Banana::RSpecListener.instrument!
  end
  
  def bootstrap_minitest!
    require_relative 'TODO'
  end
end