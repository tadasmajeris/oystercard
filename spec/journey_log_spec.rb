require 'journey_log'


# describe JourneyLog do
# subject (:journeylog) {described_class.new(station)}
# let(:station){double :station}
# let(:station2){double :station}
# let(:journey) {double :journey, entry_station: station, exit_station: station2}
# allow(journey).to receive(:finish).and_return {@exit_station = station2}
# allow(journey).to receive(:initialize).and_return{@entrance_station = station1}

#   it 'starts a journey' do
#     subject.start_journey(station)
#     expect(subject.journey.entry_station).to eq station
#   end

#   it 'ends a journey' do
#     subject.end_journey(station2)
#     expect(subject.journey.exit_station).to eq station
#   end

#   it 'stores a journey' do
#     expect { subject.record(journey) }.to change { subject.log.count }.by 1
#   end

# end
