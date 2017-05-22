class RoomController < ApplicationController
   before_action :authenticate_user!
   
   def index
    @rooms = current_user.rooms
   end

  def create
   room = Room.new
    room.user_id = current_user.id
    room.save
    room.places.create(user_id: current_user.id, lat: 37.5431636,lng: 126.8659771)
    redirect_to show_path(room.id)
  end

  def show
    @room = Room.find(params[:id])
    # room.places에 current_user있으면 무시, 없으면 추가
    if !@room.places.where(user_id: current_user.id).exists?
      @room.places.create(user_id: current_user.id, lat: 37.5431636,lng: 126.8659771)
    end
  end
  
  def find
  end
  
  def find_temp
    #   room = Room.find(params[:id])
    #   place = room.places.find(params[:place][:user_id])
    #   place.lat = params[:place][:lat]
    #   place.lng = params[:place][:lng]
    #   place.save
    #   redirect_to :back
    
     @room = Room.find(params[:id])
      place = @room.places.where(user_id: params[:place][:user_id]).first
      place.lat = params[:place][:lat]
      place.lng = params[:place][:lng]
   
    respond_to do |format|
        if place.save
            format.js
        else
        #   format.html { render 'new'} ## Specify the format in which you are rendering "new" page
        #   format.json { render json: @reservation.errors } ## You might want to specify a json format as well
        end
    end
    #   redirect_to :back
      
      
  end
  
  def result
       @room = Room.find(params[:id])
       count = @room.places.length
       @sum_lat = 0
       @sum_lng = 0
       @room.places.each do |place|
           @sum_lat+=place.lat
           @sum_lng+=place.lng
       end
       @sum_lat/=count
       @sum_lng/=count
  end
  
  def result2
       @room = Room.find(params[:id])
       count = @room.places.length
       @sum_lat = 0
       @sum_lng = 0
       @room.places.each do |place|
           @sum_lat+=place.lat
           @sum_lng+=place.lng
       end
       @sum_lat/=count
       @sum_lng/=count
       
       
  end
  
end
