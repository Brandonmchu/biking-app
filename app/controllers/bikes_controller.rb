class BikesController < ApplicationController

def new

end

def show

end

def index
  @posts = Bike.order('created_at DESC').limit(50).all
  if params[:lastDate] != nil
    lastDate = params[:lastDate]
    @postsnew = @posts.find_all { |post| post.created_at > (lastDate.to_time + 1.minutes).to_datetime }
  end

  respond_to do |format|
    format.js { render :bike_post_ajax }
    format.html
  end
end

end
