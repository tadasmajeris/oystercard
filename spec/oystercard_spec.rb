require 'oystercard'

describe Oystercard do

  let(:station) { double :station }
  let(:station2) { double :station }
  let(:journey_log) { JourneyLog.new(Journey)}
  subject {Oystercard.new(journey_log)}


  describe "Initialization of a card" do
    it "has an initial balance of 0" do
      expect(subject.balance).to eq 0
    end

    it "can be initialized with a journey_log" do
      expect(subject.journey_log).to eq journey_log
    end

    it 'should not be touched in' do
      expect(subject).not_to be_touched_in
    end

   end

  describe "#top_up" do
    it "can top up the balance" do
      expect {subject.top_up 10 }.to change{ subject.balance }.by 10
    end
  end

  context "When card is topped up" do
    before do
      subject.top_up(Oystercard::TOP_UP_LIMIT)
    end

    it "fails if you try to exceed top-up limit" do
      expect{subject.top_up 1}.to raise_error "Top-up limit of £#{Oystercard::TOP_UP_LIMIT} exceeded."
    end

    describe "#touch_in" do
      it 'logs the journey' do
        subject.touch_in(station)
        expect(journey_log.journeys.count).to eq 1
      end

      context 'when already touched in' do
        before do
          subject.touch_in(station)
        end
        it 'should add another journey regardless' do
          subject.touch_in(station)
          expect(journey_log.journeys.count).to eq 2
        end

        it 'should charge a penalty fare' do
          expect{ subject.touch_in(station) }.to change{ subject.balance }.by(-Journey::PENALTY_FARE)
        end

      end

    end

    describe "#touch_out" do

      context 'given an entry station' do
        before { subject.touch_in(station) }
        it "should deduct £#{Journey::MINIMUM_FARE}" do
          expect{subject.touch_out station2}.to change{subject.balance}.by(-Journey::MINIMUM_FARE)
        end
      end

      context 'when not given an entry station' do
        it 'should deduct the penalty fare' do
          expect{subject.touch_out station2}.to change{subject.balance}.by(-Journey::PENALTY_FARE)
        end
      end

    end
  end

  context "When card has insufficient money" do

    it "should produce an error if you try to touch in." do
      allow(subject).to receive(:balance) { 0 }
      expect{subject.touch_in station}.to raise_error ("Insufficient money on card for journey.")
    end
  end
end
