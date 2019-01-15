require_relative 'weather'
require_relative 'plane'

class Airport
    attr_reader :hangar
    attr_accessor :capacity

    DEFAULT_CAPACITY = 10

    def initialize (capacity = DEFAULT_CAPACITY)
        @hangar = []
        @capacity = capacity
    end

    def land(plane, weather = Weather.new)
        raise "Landing Forbidden - STORMY weather" if weather.stormy
        raise "Plane cannot land - capacity full" if @hangar.length >= @capacity
        @hangar.push(plane)
        plane.at_airport = true
        plane
    end

    def takeoff(plane, weather = Weather.new)
        raise "Takeoff forbidden - STORMY weather" if weather.stormy
        @hangar.delete(plane)
        plane.leave_airport
        plane
    end
end
