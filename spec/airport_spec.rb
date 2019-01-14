require 'airport'
require 'plane'
require 'weather'

describe Airport do
    before (:each) do
      @jet = Plane.new
      @heathrow = Airport.new
      @weather = Weather.new
    end

    describe '#land' do
        it "airport lands a plane" do
          expect(@heathrow.land(@jet)).to eq @jet
        end

        it 'prevents landing when weather is stormy' do
          @weather.stormy = true
          expect { @heathrow.land(@jet, @weather) }.to raise_error 'Landing Forbidden - STORMY weather'
        end
    end

    describe '#takeoff' do
        it "airport takes off a plane" do
          @heathrow.land(@jet)
          expect(@heathrow.takeoff(@jet)).to eq @jet
        end

        it "confirms taken off plane no longer at airport" do
            @heathrow.land(@jet)
            @heathrow.takeoff(@jet)
            expect(@heathrow.hangar.include? @jet).to eq false
        end

        it 'prevents takeoff (and returns error) when weather is stormy' do
            @heathrow.land(@jet)
            @weather.stormy = true
            expect { @heathrow.takeoff(@jet, @weather) }.to raise_error 'Takeoff forbidden - STORMY weather'
        end
    end
end


# it "should return an error if docking station is empty" do
# end
#
# def release_bike
#     fail 'There are no bikes!' if empty?
#     @docks.shift()
# end
