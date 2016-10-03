class Oystercard

  TOP_UP_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if balance + money > TOP_UP_LIMIT
    @balance += money
    "Your new balance is £#{balance}"
  end
  
  def deduct money
      @balance -= money
  end

end
