class BikesController < ApplicationController

def new

end

def show

end

def index
  @bikes = Bike.all
end

end
