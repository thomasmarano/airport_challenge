class Weather
    attr_accessor :stormy
    def initialize
        num = rand(0..10)
        num < 8 ? @stormy = false : @stormy = true
    end
end
