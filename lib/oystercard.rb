class Oystercard

  attr_reader :balance
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def topup(amount)
    fail "Cannot topup! Exceeds maximum balance of #{MAX_BALANCE}." if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    fail "Cannot deduct! You don't have the funds!" if amount > balance
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Already touched in" if in_journey?
    fail "Insufficient funds" if balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    fail "Not touched in" unless in_journey?
    @in_journey = false
  end

end
