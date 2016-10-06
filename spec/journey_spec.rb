require 'journey'

describe Journey do
  let(:station) { double :station }

  describe 'initialize' do
    it 'has a penalty fare by default ' do
      expect(subject.fare).to eq described_class::PENALTY_FARE
    end

    it 'knows if the journey is not complete' do
      expect(subject).not_to be_complete
    end
  end

  describe '#finish' do
    it 'returns itself after exiting the journey' do
      expect(subject.finish(station)).to eq subject
    end
  end

  context 'given an entry station' do
    subject {described_class.new(station)}

    it 'has an entry_station' do
      expect(subject.entry_station).to eq station
    end

    context 'given an exit station' do
      let(:exit_station) { double :exit_station }

      before { subject.finish exit_station }

      it 'calculates a minimum fare' do
        expect(subject.fare).to eq described_class::MIN_FARE
      end

      it 'knows the journey is complete' do
        expect(subject).to be_complete
      end
    end
  end

end
