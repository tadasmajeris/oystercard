class Oystercard

  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def topup(amount)
    fail "Cannot topup! Exceeds maximum balance of #{MAX_BALANCE}." if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    fail "Cannot deduct! You don't have the funds!" if amount > balance
    @balance -= amount
  end

end
