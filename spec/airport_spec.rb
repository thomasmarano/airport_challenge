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
          weather = double("weather")
          allow(weather).to receive(:stormy).and_return(false)
            expect(@heathrow.land(@jet, weather)).to eq @jet
        end

        it 'prevents landing when weather is stormy' do
          weather = double("weather")
          allow(weather).to receive(:stormy).and_return(true)
          expect { @heathrow.land(@jet, weather) }.to raise_error 'Landing Forbidden - STORMY weather'
        end

        it 'prevents landing if hangar full (i.e. airport capacity is reached))' do
            weather = double("weather")
            allow(weather).to receive(:stormy).and_return(false)
            @heathrow.capacity = 0
            expect { @heathrow.land(@jet, weather) }.to raise_error 'Plane cannot land - capacity full'
        end

        # it "cannot land a plane again (i.e. if it is already landed)" do
        #     weather = double("weather")
        #     allow(weather).to receive(:stormy).and_return(false)
        #     @heathrow.land(@jet, weather)
        #     expect { @heathrow.land(@jet) }.to raise_error "Plane already landed"
        # end
    end

    describe '#takeoff' do
        it "airport takes off a plane" do
          weather = double("weather")
          allow(weather).to receive(:stormy).and_return(false)
          @heathrow.land(@jet, weather)
          expect(@heathrow.takeoff(@jet, weather)).to eq @jet
        end

        it "confirms taken off plane no longer at airport" do
            weather = double("weather")
            allow(weather).to receive(:stormy).and_return(false)
            @heathrow.land(@jet, weather)
            @heathrow.takeoff(@jet, weather)
            expect(@heathrow.hangar.include? @jet).to eq false
        end

        it 'prevents takeoff (and returns error) when weather is stormy' do
          landing_weather = double("landing_weather")
          allow(landing_weather).to receive(:stormy).and_return(false)
          takeoff_weather = double("takeoff_weather")
          allow(takeoff_weather).to receive(:stormy).and_return(true)
            @heathrow.land(@jet, landing_weather)
            expect { @heathrow.takeoff(@jet, takeoff_weather) }.to raise_error 'Takeoff forbidden - STORMY weather'
        end
    end
end
