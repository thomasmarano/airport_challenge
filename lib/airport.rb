#require_relative 'weather'

class Airport
    attr_reader :hangar
    def initialize
        @hangar = []
    end

    def land(plane)
        @hangar.push(plane)
    end

    def takeoff(plane)
        @hangar.delete(plane)
        plane.leave_airport
        plane
    end
end
