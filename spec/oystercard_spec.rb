require "oystercard"

describe Oystercard do

  it "defaults to balance of 0" do
    expect(subject.balance).to eq 0
  end

  describe "#topup" do
    it "should allow you to topup" do
      expect{ subject.topup(10) }.to change{ subject.balance }.by 10
    end
  end

end
