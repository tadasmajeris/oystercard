class Station
  attr_reader :name, :zone

  def initialize(hash = {})
    fail "must use Station.new(name: 'station', zone: n)" if hash.class != Hash || hash.empty?
    @name = hash[:name]
    @zone = hash[:zone]
  end
end
