require "station"

describe Station do

  describe "Initialization" do

    context "wrong arguments" do
      let(:error) { "must use Station.new(name: 'station', zone: n)" }

      it "should raise error if no arguments passed" do
        expect{Station.new}.to raise_error error
      end
      it "should raise error if argument is not a hash" do
        expect{Station.new('eggs')}.to raise_error error
      end
    end

    subject(:station) { Station.new(name: "Limehouse", zone: 2) }
    it "should allow setting a name" do
      expect(station.name).to eq "Limehouse"
    end
    it "should allow setting a zone" do
      expect(station.zone).to eq 2
    end
  end
end
