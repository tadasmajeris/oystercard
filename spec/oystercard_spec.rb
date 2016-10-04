require "oystercard"

describe Oystercard do

  let(:start_station) { double(:station) }
  let(:end_station) { double(:station) }

  describe "Initialization" do
    it "creates an empty journey history" do
      expect(subject.journeys).to be_empty
    end
    it "defaults to balance of 0" do
      expect(subject.balance).to eq 0
    end
    it "creates an empty journey" do
      expect(subject.journey).to be nil
    end
  end

  describe "#topup" do
    it "wont allow you to exceed the maximum balance" do
      max_balance = Oystercard::MAX_BALANCE
      expect{ subject.topup(max_balance+1) }.to raise_error "Exceeds maximum balance of #{max_balance}."
    end

    it "should allow you to topup" do
      expect{ subject.topup(10) }.to change{ subject.balance }.by 10
    end
  end

  describe "#in_journey?" do
    it "should return false when card is new" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it "raises an error if balance is insufficient" do
      allow(subject).to receive(:balance).and_return(0)
      expect{ subject.touch_in(start_station) }.to raise_error "Insufficient funds"
    end
    it "should allow you to touch in" do
      subject.topup(Oystercard::MIN_FARE)
      subject.touch_in(start_station)
      expect(subject).to be_in_journey
    end
  end

  describe "#touch_out" do
    before do
      subject.topup(Oystercard::MIN_FARE)
      subject.touch_in(start_station)
    end

    it "should allow you to touch out" do
      subject.touch_out(end_station)
      expect(subject).not_to be_in_journey
    end
    it "should deduct balance on touch out" do
      expect{ subject.touch_out(end_station) }.to change{ subject.balance }.by -Oystercard::MIN_FARE
    end
    it "should save a journey" do
      journey = subject.journey
      subject.touch_out(end_station)
      expect(subject.includes_journey?(journey)).to be true
    end
    it "should forget the start station on touch out" do
      subject.touch_out(end_station)
      expect(subject.journey).to be nil
    end
  end
end
