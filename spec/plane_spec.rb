require 'plane'
require 'airport'

describe Plane do
    before (:each) do
        @jet = Plane.new
        @weather = double("weather")
        allow(@weather).to receive(:stormy?).and_return(false)
    end

    describe '#at_airport' do
        it 'confirms it is no longer at airport after takeoff' do
            airport = Airport.new(Airport::DEFAULT_CAPACITY, @weather)
            airport.takeoff(@jet)
            expect(@jet.at_airport).to eq false
          end
    end
end
