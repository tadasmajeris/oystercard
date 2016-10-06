require 'journey'

describe Journey do

  let(:station){double :station}
  let(:station2){double :station}
  subject(:journey) { Journey.new(station) }

  describe "Initialization" do


    it "has an entry station" do
      expect(journey.entry_station).to eq station
    end
  end

  it {is_expected.to respond_to :finish}
  it {is_expected.to respond_to :fare}
  it {is_expected.to respond_to :complete?}

  describe '#finish' do
    it 'adds an exit station'  do
      subject.finish(station)
      expect(subject.exit_station).to eq station
    end
  end

  describe '#complete' do
    it "sets the journey to complete" do
      subject.finish (station)
      expect(subject).to be_complete
    end
  end

  describe '#fare' do
    it "sets the correct fare" do
      subject.finish (station)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
  end

end
