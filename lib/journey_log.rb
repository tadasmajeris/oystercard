require_relative 'oystercard'
require_relative 'journey'

class JourneyLog
  
  def initialize(station)
    @journeys = []
    @journey = station
  end
  
  def start_journey(station)
    @journey = Journey.new(station)
  end
    
  def end_journey(station)
    @journey.finish(station)
  end
    
  def record(journey)
    @journeys << journey
  end
    
end
