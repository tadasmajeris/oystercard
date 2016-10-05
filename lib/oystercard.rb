class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if balance + money > TOP_UP_LIMIT
    @balance += money
    return_balance
  end

  def in_journey?
    !entry_station.nil?
  end

  def touch_in(station)
    fail "Insufficient money on card for journey." if balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
    return_balance
  end

  private

  def return_balance
    "Your balance is £#{balance}"
  end

  def deduct money
    @balance -= money
  end

end
