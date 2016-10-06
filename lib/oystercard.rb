require_relative 'journey'

class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journey, :journeys

  def initialize
    @balance = 0
    @journey = nil
    @journeys = []
  end

  def top_up money
    check_limit(money)
    @balance += money
    return_balance
  end

  def in_journey?
    !!@journey
  end

  def touch_in(station)
    check_minimum
    charge_penalty if double_touch_in?
    start_journey(station) 
  end

  def touch_out(station)
    if double_touch_out?
      charge_penalty
    else
      charge_fare
      complete_journey(station)
      return_balance
    end
  end



  private
  def check_limit(money)
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if balance + money > TOP_UP_LIMIT
  end

  def check_minimum
    fail "Insufficient money on card for journey." if balance < MINIMUM_FARE
  end
  
  def start_journey(station)
    @journey = Journey.new(station)
  end

  def return_balance
    "Your balance is £#{balance}"
  end

  def deduct(money)
    @balance -= money
  end

  def double_touch_in?
  !!@journey
  end
  
  def charge_penalty
    @balance -= PENALTY_FARE
    puts "You forgot to touch out" if double_touch_in?
    puts "You forgot to touch in" if double_touch_out?
  end

  def double_touch_out?
    !@journey
  end
  
  def charge_fare
   deduct(MINIMUM_FARE)
  end
  
  def complete_journey(station)
    @journey.finish(station)
    @journeys << journey
    @journey = nil
  end  

end
