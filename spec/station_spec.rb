require 'station'
describe Station do

  let(:station) {described_class.new(name: :limehouse, zone: 2)}

  describe "Initialization" do
    it "should set the name" do
      expect(station.name).to eq :limehouse
    end
    it "should set the zone" do
      expect(station.zone).to eq 2
    end
  end
end
