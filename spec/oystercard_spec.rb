require "oystercard"

describe Oystercard do

  it "defaults to balance of 0" do
    expect(subject.balance).to eq 0
  end

  describe "#topup" do
    it "wont allow you to exceed the maximum balance" do
      max_balance = Oystercard::MAX_BALANCE
      expect{ subject.topup(max_balance+1) }.to raise_error "Cannot topup! Exceeds maximum balance of #{max_balance}."
    end

    it "should allow you to topup" do
      expect{ subject.topup(10) }.to change{ subject.balance }.by 10
    end
  end

  describe "#deduct" do
    it "wont allow your balance to go below zero" do
      expect{ subject.deduct(subject.balance+10) }.to raise_error "Cannot deduct! You don't have the funds!"
    end

    it "should allow you to deduct" do
      subject.topup(10)
      expect{ subject.deduct(10) }.to change{ subject.balance }.by -10
    end
  end

  describe "#in_journey?" do
    it "should return false when card is new" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it "raises an error if are already in a journey" do
      allow(subject).to receive(:in_journey?).and_return(true)
      expect{ subject.touch_in }.to raise_error "Already touched in"
    end
    it "raises an error if balance is insufficient" do
      allow(subject).to receive(:balance).and_return(0)
      expect{ subject.touch_in }.to raise_error "Insufficient funds"
    end
    it "should allow you to touch in" do
      allow(subject).to receive(:balance).and_return(Oystercard::MIN_FARE)
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe "#touch_out" do
    it "raises an error if are not in a journey" do
      allow(subject).to receive(:in_journey?).and_return(false)
      expect{ subject.touch_out }.to raise_error "Not touched in"
    end
    it "should allow you to touch out" do
      allow(subject).to receive(:balance).and_return(Oystercard::MIN_FARE)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
