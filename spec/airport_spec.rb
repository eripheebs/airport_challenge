require 'airport'

describe Airport do
  subject(:airport) { described_class.new }
  let(:plane) {double :plane}

  describe 'initialize' do

    it 'expects airport to have a capacity that is set to the default capacity if nothing is specified' do
      expect(subject.capacity).to eq described_class::DEFAULT_CAPACITY
    end

    it 'expects the capacity to be able to be set when initialized' do
      airport = Airport.new 13
      expect(airport.capacity).to eq 13
    end

  end

  describe 'land' do

    it 'expects the plane to land into the airport when weather is fine' do
      allow(plane).to receive(:is_landed).and_return(true)
      allow(subject).to receive(:is_stormy?).and_return(false)
      subject.land(plane)
      expect(subject.list_planes).to include(plane)
    end

    it 'expects landing to be prevented when weather is stormy' do
      allow(plane).to receive(:is_landed).and_return(true)
      allow(subject).to receive(:is_stormy?).and_return(true)
      expect{subject.land(plane)}.to raise_error "It's too stormy to land."
    end

    it 'expects landing to be prevented when airport is full' do
      allow(plane).to receive(:is_landed).and_return(true)
      allow(subject).to receive(:is_stormy?).and_return(false)
      10.times{subject.land(plane)}
      expect{subject.land(plane)}.to raise_error "Airport is full! Plane cannot land."
    end

  end

  describe 'takeoff' do

    before do
      allow(plane).to receive(:is_landed).and_return(true)
      allow(subject).to receive(:is_stormy?).and_return(false)
      subject.land(plane)
    end

    it 'expects the plane to take off from the airport when weather is fine' do
      allow(plane).to receive(:took_off).and_return(true)
      allow(subject).to receive(:is_stormy?).and_return(false)
      subject.takeoff(plane)
      expect(subject.list_planes).to eq([])
    end

    it 'expects takeoff to be prevented when weather is stormy' do
      allow(plane).to receive(:took_off).and_return(true)
      allow(subject).to receive(:is_stormy?).and_return(true)
      expect{subject.takeoff(plane)}.to raise_error "It's too stormy to take-off."
    end

  end

end
