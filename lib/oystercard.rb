require_relative 'journey'

class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey, :journeys

  def initialize
    @balance = 0
    @journey = nil
    @journeys = []
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if balance + money > TOP_UP_LIMIT
    @balance += money
    return_balance
  end

  def in_journey?
    !!@journey
  end

  def touch_in(station)
    fail "Insufficient money on card for journey." if balance < MINIMUM_FARE
    @journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey.finish(station)
    @journeys << journey
    @journey = nil
    return_balance
  end

  private

  def return_balance
    "Your balance is £#{balance}"
  end

  def deduct(money)
    @balance -= money
  end

end
