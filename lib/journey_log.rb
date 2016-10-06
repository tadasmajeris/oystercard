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
    @journeys << current_journey if no_current_journey?
    current_journey.finish(station)
    @current_journey = nil
  end

  def no_current_journey?
    @current_journey.nil?
  end

  def journeys
    @journeys.dup
  end

  def last_fare
    @journeys.last.fare
  end

  private

  def current_journey
    @current_journey ||= @journey_class.new
  end
end
