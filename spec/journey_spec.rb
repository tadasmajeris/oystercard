require 'journey'

describe Journey do
  let(:station) {double(:station, zone: 1)}

  describe "Initialization" do
    it "has a default penalty fare" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    it "sets the journey as incomplete" do
      expect(subject).not_to be_complete
    end
  end

  describe "#finish" do
    it "returns itself on journey exit" do
      expect(subject.finish(station)).to eq(subject)
    end
  end

  context 'given an entry station' do

    subject {described_class.new(entry_station: station)}

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end
    it "returns a penalty fare if no exit station given" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      let(:other_station) { double :other_station }

      before do
        subject.finish(other_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end
      it "knows if a journey is complete" do
        expect(subject).to be_complete
      end
    end
  end
end
