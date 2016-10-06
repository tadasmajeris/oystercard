
class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :fare

  def initialize(station)
    @entry_station = station
    @fare = PENALTY_FARE
  end

end
