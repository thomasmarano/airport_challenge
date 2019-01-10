class Airport
    attr_reader :planes
    def initialize
        @planes = []
    end

    def land(plane)
        @planes.push(plane)
        plane
    end

    def takeoff(plane)
        @planes.delete(plane)
        plane
    end
end
