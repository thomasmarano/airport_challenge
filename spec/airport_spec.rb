require 'airport'
require 'plane'
require 'weather'

describe Airport do

    before (:each) do
      @jet = Plane.new
      @weather = double("weather")
      allow(@weather).to receive(:stormy?).and_return(false)
    end

    describe '#land' do
        it "airport lands a plane" do
            airport = Airport.new(Airport::DEFAULT_CAPACITY, @weather)
            @jet.at_airport = false
            expect(airport.land(@jet)).to eq @jet
        end

        it "prevents landing when weather is stormy" do
            allow(@weather).to receive(:stormy?).and_return(true)
            airport = Airport.new(Airport::DEFAULT_CAPACITY, @weather)
            expect { airport.land(@jet) }.to raise_error "Stormy weather"
        end

        it 'prevents landing if hangar full (i.e. airport capacity is reached))' do
            airport = Airport.new(0, @weather)
            @jet.at_airport = false
            expect { airport.land(@jet) }.to raise_error 'Capacity full'
        end

        it "cannot land a plane again (i.e. if it is already landed)" do
            airport = Airport.new(Airport::DEFAULT_CAPACITY, @weather)
            expect { airport.land(@jet) }.to raise_error "Plane already landed"
        end

        it "can land multiple planes" do
            airport = Airport.new(Airport::DEFAULT_CAPACITY, @weather)
            jet2 = Plane.new
            jet2.at_airport = false
            @jet.at_airport = false
            airport.land(@jet)
            expect(airport.land(jet2)).to eq jet2
        end
    end

    # describe '#takeoff' do
    #     it "airport takes off a plane" do
    #         airport = Airport.new(Airport::DEFAULT_CAPACITY, @weather)
    #         @jet.at_airport = true
    #         expect(@heathrow.takeoff(@jet, @weather)).to eq @jet
    #     end
    #
    #     it "confirms taken off plane no longer at airport" do
    #         @heathrow.takeoff(@jet, @weather)
    #         expect(@jet.at_airport).to eq false
    #     end
    #
    #     it 'prevents takeoff (and returns error) when weather is stormy' do
    #         allow(@weather).to receive(:stormy).and_return(true)
    #         @jet.at_airport = true
    #         expect { @heathrow.takeoff(@jet, @weather) }.to raise_error 'Stormy weather'
    #     end
    #
    #     it "raises an error if plane, already in the air, tries to take off" do
    #         @jet.at_airport = false
    #         expect {@heathrow.takeoff(@jet, @weather)}.to raise_error "Plane already in air"
    #     end
    # end
end
