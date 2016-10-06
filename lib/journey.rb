class Journey

 attr_reader :entry_station, :exit_station

 def initialize(station)
  @entry_station = station
  @exit_station
 end

 def finish(station)
   @exit_station = station
 end

 def fare

 end

 def complete?

 end

end
