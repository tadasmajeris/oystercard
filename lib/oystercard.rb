class Oystercard

  attr_reader :balance, :journey, :journeys
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
    @journey = {}
  end

  def topup(amount)
    fail_if_exceeds_balance(amount)
    @balance += amount
  end

  def in_journey?
    !@journey.empty?
  end

  def touch_in(station)
    fail "Already touched in" if in_journey?
    fail "Insufficient funds" if balance < MIN_FARE
    journey[:start] = station
  end

  def touch_out(station)
    fail "Not touched in" unless in_journey?
    deduct(MIN_FARE)
    journey[:end] = station
    add_journey
    @journey = {}
  end

  def includes_journey?(journey)
    journeys.include?(journey)
  end

  private

  def add_journey
    journeys << journey
  end

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
