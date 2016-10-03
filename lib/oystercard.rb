class Oystercard

  attr_reader :balance, :start_station
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
  end

  def topup(amount)
    fail_if_exceeds_balance(amount)
    @balance += amount
  end

  def in_journey?
    !@start_station.nil?
  end

  def touch_in(station)
    fail "Already touched in" if in_journey?
    fail "Insufficient funds" if balance < MIN_FARE
    @start_station = station
  end

  def touch_out
    fail "Not touched in" unless in_journey?
    deduct(MIN_FARE)
    @start_station = nil
  end

  private

  def fail_if_exceeds_balance(n)
    fail "Exceeds maximum balance of #{MAX_BALANCE}." if exceeds_balance(n)
  end

  def exceeds_balance(n)
    (balance + n) > MAX_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
