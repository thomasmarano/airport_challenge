class Weather
    def stormy?
        num = rand(0..10)
        num < 8 ? false : true
    end
end
