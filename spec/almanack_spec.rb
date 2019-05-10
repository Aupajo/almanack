RSpec.describe Almanack do
  describe "#config" do
    specify { expect(Almanack.config).to be_an_instance_of(Almanack::Configuration) }
    specify { expect { |probe| Almanack.config(&probe) }.to yield_control }
  end
end
