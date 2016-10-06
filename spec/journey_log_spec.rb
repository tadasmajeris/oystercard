require 'journey_log'

describe JourneyLog do

  let(:journey){ double :journey, fare: Journey::PENALTY_FARE }
  let(:station){ double :station }
  let(:journey_class){double :journey_class, new: journey}
  subject {described_class.new(journey_class)}

  describe 'Initialization' do
    it 'sets journeys as empty at start' do
      expect(subject.journeys).to eq []
    end
  end

  describe '#start' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(station)
      subject.start(station)
    end

    it 'records a journey' do
      subject.start(station)
      expect(subject.journeys).to include journey
    end
  end

  describe '#finish' do
    let(:exit_station){double :exit_station}

    before {subject.start(station)}

    it 'finishes the journey' do
      expect(journey).to receive(:finish).with(exit_station)
      subject.finish(exit_station)
    end

    it 'resets current_journey to nil' do
      allow(journey).to receive(:finish).with(exit_station)
      subject.finish(exit_station)
      expect(subject.no_current_journey?).to be true
    end

    context 'given no entry station' do
      it 'should still create a journey' do
        allow(journey).to receive(:finish).with(exit_station)
        subject.finish(exit_station)
        expect(subject.journeys).to include journey
      end
    end
  end

  describe '#last_fare' do
    it 'should return the last fare' do
      allow(journey).to receive(:finish).with(station)
      subject.finish(station)
      expect(subject.last_fare).to eq Journey::PENALTY_FARE
    end
  end
end
