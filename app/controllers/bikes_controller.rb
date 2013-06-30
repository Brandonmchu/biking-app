class BikesController < ApplicationController

def new

end

def show

end

def index
  @bikes = Bike.order('created_at DESC').limit(50).all
end

end
