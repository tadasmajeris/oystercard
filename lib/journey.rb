class Journey

  attr_reader :entry_station, :exit_station, :fare

  MINIMUM_FARE = 1


  def initialize(station)
    @entry_station = station
    @exit_station
  end

  def finish(station)
    @exit_station = station
    @complete = true
  end

  def fare
    MINIMUM_FARE
  end

  def complete?
    @complete
  end

end
