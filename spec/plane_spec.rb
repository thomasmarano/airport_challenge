require 'plane'
require 'airport'

describe Plane do
    before (:each) do
        @jet = Plane.new
        @heathrow = Airport.new
    end

    describe '#at_airport' do
        it 'confirms it is no longer at airport after takeoff' do
            weather = double("weather")
            allow(weather).to receive(:stormy).and_return(false)
            @heathrow.takeoff(@jet, weather)
            expect(@jet.at_airport).to eq false
          end
    end
end
