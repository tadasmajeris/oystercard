require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "has an initial balance of 0" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it "can top up the balance" do
    expect {subject.top_up 10 }.to change{ subject.balance }.by 10
  end

  it "has a top_up limit" do
    expect(Oystercard::TOP_UP_LIMIT).to exist
  end

end
