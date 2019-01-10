require 'airport'
require 'plane'

describe Airport do
    describe '#land' do
        it "airport lands a plane" do
          jet = Plane.new
          expect(subject.land(jet)).to eq jet
        end
    end
    describe '#takeoff' do
        it "airport takes off a plane" do
          jet = Plane.new
          expect(subject.takeoff(jet)).to eq jet
        end

        it "confirms taken off plane no longer at airport" do
            jet = Plane.new
            heathrow = Airport.new
            heathrow.land(jet)
            heathrow.takeoff(jet)
              expect(heathrow.planes.include? jet).to eq false
        end
    end
end
