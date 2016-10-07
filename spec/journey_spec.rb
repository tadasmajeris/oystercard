require 'journey'

describe Journey do

  let(:station){double :station}

  describe "Initialization" do
    it 'knows a journey is not complete' do
      expect(subject).not_to be_complete
    end
    it 'defaults to penalty fare' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  describe '#finish' do
    it 'adds an exit station'  do
      expect(subject.finish(station)).to eq subject
    end
  end

  context 'when given an entry station' do
    subject(:journey) { Journey.new(station) }

    it "has an entry station" do
      expect(journey.entry_station).to eq station
    end

    context 'when given an exit station' do
      let(:other_station) {double :other_station}
      before {subject.finish(station)}

      it "sets the journey to complete" do
        expect(subject).to be_complete
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq Journey::MINIMUM_FARE
      end
    end
  end

end
