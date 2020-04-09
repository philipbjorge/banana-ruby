require "rspec/autorun"

class Meme
  def i_can_has_cheezburger?
    "OHAI!"
  end

  def will_it_blend?
    "YES!"
  end
end

RSpec.describe Meme do
  describe '#i_can_has_cheezburger?' do
    subject { Meme.new.i_can_has_cheezburger? }
    it { is_expected.to eql("OHAI!") }
  end

  describe '#will_it_blend?' do
    subject { Meme.new.will_it_blend? }
    it { is_expected.to_not include("no") }
  end

  skip "test that will be skipped" do
  end
end