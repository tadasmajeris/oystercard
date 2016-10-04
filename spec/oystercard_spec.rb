require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "has an initial balance of 0" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  context "When topping up" do
    it "can top up the balance" do
      expect {subject.top_up 10 }.to change{ subject.balance }.by 10
    end

    it "has a top_up limit" do
      #Oystercard::TOP_UP_LIMIT = 10
      expect(Oystercard::TOP_UP_LIMIT.class).to be Fixnum
    end
  end

  context "When card is topped up" do
    before do
      subject.top_up(Oystercard::TOP_UP_LIMIT)
    end

    it "fails if you try to exceed top-up limit" do
      #maximum_balance = Oystercard::TOP_UP_LIMIT
      #subject.top_up(maximum_balance)
      expect{subject.top_up 1}.to raise_error "Top-up limit of £#{Oystercard::TOP_UP_LIMIT} exceeded."
    end

    describe "#touch_in" do
      it "should make in_journey true" do
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end

    describe "#touch_out" do
      it "should make in_journey false" do
        subject.touch_in
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
    it "should deduct £1" do
      expect{subject.touch_out}.to change{subject.balance}.by(-1)
    end
  end

  # describe "#deduct" do
  #   it "should deduct amount" do
  #     subject.top_up 40
  #     expect {subject.deduct 20}.to change{subject.balance}.by (-20)
  #   end
  # end

  describe "#in_journey" do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  context "Insufficient money on card" do

    it "produces an error." do
      allow(subject).to receive(:balance) { 0 }
      expect{subject.touch_in}.to raise_error ("Insufficient money on card for journey.")
    end
  end
end
