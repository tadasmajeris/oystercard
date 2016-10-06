class JourneyLog


  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @current_journey = @journey_class.new(station)
    @journeys << current_journey
  end

  def finish(station)
    @current_journey.finish(station)
    @current_journey = nil
  end

  def current_journey_reset?
    @current_journey.nil?
  end


  def journeys
    @journeys.dup
  end


  private

  def current_journey
    @current_journey || @journey_class.new
  end



end
