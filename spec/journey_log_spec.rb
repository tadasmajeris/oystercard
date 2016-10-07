require 'journey_log'

describe JourneyLog do
  let(:station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey }
  let(:journey_class) { double :journey_class, new: journey }
  subject { JourneyLog.new(journey_class) }

  describe 'initialization' do
    it 'has empty journey log' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#start' do
    it 'start a journey' do
      expect(journey_class).to receive(:new).and_return journey
      subject.start(station)
    end

    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      subject.start(station)
      expect(subject.journeys).to include journey
    end
  end

  describe '#finish' do
    before do
      allow(journey).to receive(:finish).with(exit_station)
      allow(journey_class).to receive(:new).and_return journey
    end

    it 'should update the current journey' do
      expect(journey).to receive(:finish).with(exit_station)
      subject.finish(exit_station)
    end
    it 'should set the current journey to nil' do
      subject.finish(exit_station)
      expect(subject.no_current_journey?).to be true
    end

    context 'given no entry station' do

      it 'should still record a journey' do
        subject.finish(exit_station)
        expect(subject.journeys).to include journey
      end

      it 'should save the exit station' do
        allow(journey).to receive(:exit_station).and_return exit_station
        subject.finish(exit_station)
        expect(subject.journeys.last.exit_station).to eq exit_station
      end
    end
  end

end
