require "oystercard"
describe Oystercard do
  it "defaults to balance of 0" do
    expect(subject.balance).to eq 0
  end
end
