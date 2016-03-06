require_relative 'plane'
require_relative 'weather'

class Airport

    DEFAULT_CAPACITY=10

    attr_reader :capacity

    def initialize(capacity=DEFAULT_CAPACITY)
      @planes = []
      @capacity = capacity
    end

    def list_planes
      planes
    end

    def land(plane)
      fail "Airport is full! Plane cannot land." if is_full?
      fail "It's too stormy to land." if is_stormy?
      plane.is_landed
      @planes << plane
    end

    def takeoff(plane)
      fail "It's too stormy to take-off." if is_stormy?
      plane.took_off
      @planes.delete(plane)
    end

  private

    attr_reader :planes

    def is_stormy?
      Weather.new.stormy?
    end

    def is_full?
      @planes.length == @capacity
    end

end
