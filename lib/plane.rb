class Plane
    attr_accessor :at_airport

    def initialize
        @at_airport = true
    end
    def leave_airport
        @at_airport = false
    end
    
    def returned_airport
        @at_airport = true
    end
end
