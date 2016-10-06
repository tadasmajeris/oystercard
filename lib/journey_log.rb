class JourneyLog


  def initialize(journey)
    @journey = journey

  end


  def start(station)
    @journey.new(station)
  end



end
