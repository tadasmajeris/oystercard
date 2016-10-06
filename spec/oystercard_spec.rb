require 'oystercard'

describe Oystercard do

  let(:station) { double :station }
  let(:station2) { double :station }
  let(:journey_log) { JourneyLog.new(Journey) }
  subject { described_class.new(journey_log) }

  describe "Initialization of a card" do
    it "has an initial balance of 0" do
      expect(subject.balance).to eq 0
    end

    it 'should accept journey log as a parameter' do
      expect(subject.journey_log).to eq journey_log
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
      it "starts the journey log" do
        expect(journey_log).to receive(:start).with(station)
        subject.touch_in(station)
      end

      context "when touching in a second time" do
        before do
          subject.touch_in(station)
        end
        it "adds another journey" do
          subject.touch_in(station2)
          expect(journey_log.journeys.count).to eq 2
        end
      end
    end

    describe "#touch_out" do
      context "when touched in" do
        it "should deduct £#{Journey::MIN_FARE}" do
          subject.touch_in station
          expect{subject.touch_out station2}.to change{subject.balance}.by(-Journey::MIN_FARE)
        end
      end
      context "when not touched in" do
        it "still adds the journey" do
          expect{subject.touch_out(station2)}.to change{journey_log.journeys.count}.by(1)
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
