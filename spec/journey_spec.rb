require 'journey'

describe Journey do
  let(:station) { double :station, zone: 2}
  subject {described_class.new(station)}

  describe 'initialize' do

    it 'has an entry_station' do
      expect(subject.entry_station).to eq station
    end

    it 'has a penalty fare by default ' do
      expect(subject.fare).to eq described_class::PENALTY_FARE
    end

  end 

end
