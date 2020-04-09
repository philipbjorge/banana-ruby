RSpec.describe Banana do
  it "has a version number" do
    expect(Banana::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
