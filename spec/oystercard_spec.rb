require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "has an initial balance of 0" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to :top_up }
  
  it "is expected to top up the card by £10." do
    subject.top_up 10
    expect(subject.balance).to eq 10
  end

end
