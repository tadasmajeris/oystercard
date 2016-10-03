class Oystercard
    
    TOP_UP_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up money
    @balance += money
  end

end
