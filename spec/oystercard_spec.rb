require 'oystercard'

describe Oystercard do

  let(:station) { double :station }
  let(:station2) { double :station }
  let(:journey) { {start: station, end: station2} }

  describe "Initialization of a card" do
    it "has an initial balance of 0" do
      expect(subject.balance).to eq 0
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'sets journeys as empty at start' do
      expect(subject.journeys).to eq []
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
      it "should make 'in_journey' true" do
        subject.touch_in station
        expect(subject).to be_in_journey
      end
      it "should save the entry station" do
        subject.touch_in station
        expect(subject.journey[:start]).to eq station
      end

    end

    describe "#touch_out" do
      it "should deduct £#{Oystercard::MINIMUM_FARE}" do
        expect{subject.touch_out station2}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
      end

      context "Complete journey" do
        before do
          subject.touch_in station
          subject.touch_out station2
        end

        it "should make 'in_journey' false" do
          expect(subject).not_to be_in_journey
        end

        it "should save the journey" do
          expect(subject.journeys).to include journey
        end

        it "sets journey to empty hash" do
          expect(subject.journey).to be_empty
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
