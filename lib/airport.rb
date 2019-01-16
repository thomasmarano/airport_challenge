require_relative 'weather'
require_relative 'plane'

class Airport
    attr_reader :hangar
    attr_accessor :capacity

    DEFAULT_CAPACITY = 10

    def initialize (capacity = DEFAULT_CAPACITY, weather = Weather.new)
        @hangar = []
        @capacity = capacity
        @weather = weather
    end

    def land(plane)
        raise "Stormy weather" if stormy?
        raise "Capacity full" if full?
        raise "Plane already landed" if plane.at_airport
        @hangar.push(plane)
        plane.returned_airport
        plane
    end

    def takeoff(plane)
        raise "Stormy weather" if stormy?
        raise "Plane already in air" if !plane.at_airport
        @hangar.delete(plane)
        plane.leave_airport
        plane
    end

    def stormy?
        @weather.stormy?
    end

    def full?
        @capacity <= @hangar.length
    end
end
