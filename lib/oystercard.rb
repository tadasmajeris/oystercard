require_relative "journey_log"
require_relative "journey"

class Oystercard

  TOP_UP_LIMIT = 90

  attr_reader :balance, :journey_log

  def initialize(journey_log = JourneyLog.new(Journey))
    @balance = 0
    @journey_log = journey_log
    @touched_in = false
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if balance + money > TOP_UP_LIMIT
    @balance += money
    return_balance
  end

  def touch_in(station)
    fail "Insufficient money on card for journey." if balance < Journey::MIN_FARE
    deduct(journey_log.last_fare) if @touched_in
    journey_log.start(station)
    @touched_in = true
  end

  def touch_out(station)
    journey_log.finish(station)
    deduct(journey_log.last_fare)
    @touch_in = false
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
