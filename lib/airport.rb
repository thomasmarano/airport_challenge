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

    def land(plane, weather)
        raise "Landing Forbidden - STORMY weather" if weather.stormy
        raise "Plane cannot land - capacity full" if @hangar.length >= @capacity
        raise "Plane already landed" if plane.at_airport
        @hangar.push(plane)
        plane.returned_airport
        plane
    end

    def takeoff(plane, weather)
        raise "Takeoff forbidden - STORMY weather" if weather.stormy
        raise "Plane already in air - cannot takeoff" if !plane.at_airport
        @hangar.delete(plane)
        plane.leave_airport
        plane
    end
end
