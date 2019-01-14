#require_relative 'weather'

class Airport
    attr_reader :hangar
    def initialize
        @hangar = []
    end

    def land(plane, weather = Weather.new)
        raise "Landing Forbidden - STORMY weather" if weather.stormy
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
