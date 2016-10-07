require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  TOP_UP_LIMIT = 90

  attr_reader :balance, :journey_log

  def initialize(journey_log = JourneyLog.new(Journey))
    @balance = 0
    @journey_log = journey_log
    @touched_in = false
  end

  def top_up(amount)
    fail_if_limit_exceeded(amount)
    @balance += amount
    return_balance
  end

  def touch_in(station)
    fail_if_no_money
    deduct_fare if touched_in?
    journey_log.start(station)
    @touched_in = true
  end

  def touch_out(station)
    @touched_in = false
    journey_log.finish(station)
    deduct_fare
    return_balance
  end

  def touched_in?
    @touched_in
  end

  private

  def fail_if_limit_exceeded(amount)
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if balance + amount > TOP_UP_LIMIT
  end

  def fail_if_no_money
    fail "Insufficient money on card for journey." if balance < Journey::MINIMUM_FARE
  end

  def deduct_fare
    deduct(journey_log.journeys.last.fare)
  end

  def return_balance
    "Your balance is £#{balance}"
  end

  def deduct(money)
    @balance -= money
  end

end
