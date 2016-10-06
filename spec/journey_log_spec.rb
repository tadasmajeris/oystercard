require 'journey_log'


describe JourneyLog do

  let(:journey){ double :journey }
  let(:station){ double :station }
  let(:journey_class){double :journey_class, new: journey}
  subject {described_class.new(journey_class)}

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
      expect(subject.current_journey_reset?).to be true
    end
  end

  

end
