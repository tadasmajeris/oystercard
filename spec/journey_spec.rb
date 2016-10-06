require 'journey'

describe Journey do
  let(:station){double :station}
  subject(:journey) { Journey.new(station) }

  describe "Initialization" do
    it "has an entry station" do
      expect(journey.entry_station).to eq station
    end
  end

  it {is_expected.to respond_to :finish}
  it {is_expected.to respond_to :fare}
  it {is_expected.to respond_to :complete?}


end
