require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey, :journeys
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
    @journey = nil
  end

  def topup(amount)
    fail_if_exceeds_balance(amount)
    @balance += amount
  end

  def in_journey?
    !@journey.nil?
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < Journey::MIN_FARE
    journey.finish() if journey
    @journey = Journey.new({entry_station: station})
  end

  def touch_out(station)
    @journey = journey || Journey.new
    @journey = journey.finish(station)
    deduct(journey.fare)
    add_journey
    @journey = nil
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
