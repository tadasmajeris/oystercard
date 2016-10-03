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

end
