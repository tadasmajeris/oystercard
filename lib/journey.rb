class Journey

  attr_reader :entry_station, :exit_station, :fare

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station = nil)
    @entry_station = station
    @fare = PENALTY_FARE
    @complete = false
  end

  def finish(station)
    @exit_station = station
    @fare = calculate_fare if @entry_station
    @complete = true
    self
  end

  def complete?
    @complete
  end

  private

  def calculate_fare
    zone_diff = entry_station.zone - exit_station.zone
    MINIMUM_FARE + zone_diff.abs
  end

end
