require 'airport'
require 'plane'
require 'weather'

describe Airport do

    before (:each) do
      @jet = Plane.new
      @heathrow = Airport.new
      @weather = double("weather")
      allow(@weather).to receive(:stormy).and_return(false)
    end

    describe '#land' do
        it "airport lands a plane" do
            jet = double("plane status")
            allow(jet).to receive(:at_airport).and_return(false)
            allow(jet).to receive(:returned_airport).and_return(jet)
            expect(@heathrow.land(jet, @weather)).to eq jet
        end

        it 'prevents landing when weather is stormy' do
            allow(@weather).to receive(:stormy).and_return(true)
            expect { @heathrow.land(@jet, @weather) }.to raise_error 'Landing Forbidden - STORMY weather'
        end

        it 'prevents landing if hangar full (i.e. airport capacity is reached))' do
            @heathrow.capacity = 0
            expect { @heathrow.land(@jet, @weather) }.to raise_error 'Plane cannot land - capacity full'
        end

        it "cannot land a plane again (i.e. if it is already landed)" do
            expect { @heathrow.land(@jet, @weather) }.to raise_error "Plane already landed"
        end

        it "can land multiple planes" do
            jet2 = Plane.new
            jet2.at_airport = false
            @jet.at_airport = false
            @heathrow.land(@jet, @weather)
            expect(@heathrow.land(jet2, @weather)).to eq jet2
        end
    end

    describe '#takeoff' do
        it "airport takes off a plane" do
          @jet.at_airport = true
          expect(@heathrow.takeoff(@jet, @weather)).to eq @jet
        end

        it "confirms taken off plane no longer at airport" do
            @heathrow.takeoff(@jet, @weather)
            expect(@jet.at_airport).to eq false
        end

        it 'prevents takeoff (and returns error) when weather is stormy' do
          allow(@weather).to receive(:stormy).and_return(true)
          @jet.at_airport = true
          expect { @heathrow.takeoff(@jet, @weather) }.to raise_error 'Takeoff forbidden - STORMY weather'
        end

        it "raises an error if plane, already in the air, tries to take off" do
          @jet.at_airport = false
          expect {@heathrow.takeoff(@jet, @weather)}.to raise_error "Plane already in air - cannot takeoff"
        end
    end
end
