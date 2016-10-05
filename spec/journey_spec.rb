require 'journey'

describe Journey do
  let(:station){double :station}
  subject(:journey) { Journey.new(entry_station: station) }
  
  describe "Initialization" do
    it "allows an entry station as an optional argument" do
      expect(journey.entry_station).to eq station
    end
  end
 
  it {is_expected.to respond_to :finish}
  it {is_expected.to respond_to :fare}
  it {is_expected.to respond_to :complete?}
 
 
end