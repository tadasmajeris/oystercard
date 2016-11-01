require 'journey'

describe Journey do

  let(:station_1) { double :station, zone: 1 }
  let(:station_2) { double :station, zone: 2 }
  let(:station_3) { double :station, zone: 3 }
  let(:station_5) { double :station, zone: 5 }

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
      expect(subject.finish(station_1)).to eq subject
    end
  end

  context 'when given an entry station' do
    subject(:journey) { Journey.new(station_1) }

    it "has an entry station" do
      expect(journey.entry_station).to eq station_1
    end

    context 'when given an exit station' do

      it "sets the journey to complete" do
        subject.finish(station_2)
        expect(subject).to be_complete
      end

      describe 'calculates a fare' do
        it 'should be a minimum fare when travelling within the zone' do
          subject.finish(station_1)
          expect(subject.fare).to eq Journey::MINIMUM_FARE
        end
        it 'should be minimum fare (+1) when travelling between zone 1-2' do
          subject.finish(station_2)
          expect(subject.fare).to eq(Journey::MINIMUM_FARE+1)
        end
        it 'should be minimum fare (+4) when travelling between zone 1-5' do
          subject.finish(station_5)
          expect(subject.fare).to eq(Journey::MINIMUM_FARE+4)
        end
      end
    end
  end

end
