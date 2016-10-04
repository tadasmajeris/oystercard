class Journey

  MIN_FARE = 1
  PENALTY_FARE = 4

  attr_reader :fare, :entry_station

  def initialize(args = {})
    @fare = PENALTY_FARE
    @complete = false
    @entry_station = args[:entry_station]
  end

  def complete?
    @complete
  end

  def finish(station)
    @fare = MIN_FARE if entry_station
    @complete = true
    self
  end
end
