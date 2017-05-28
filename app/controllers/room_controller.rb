class RoomController < ApplicationController
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller? 

  ####################### 메인화면(index) ##########################
  def index
    @rooms = Room.all
  end

  # create new room, put in creator's place 
  def create
   room = Room.new
    room.user_id = current_user.id
    room.save
    room.places.create(user_id: current_user.id, lat: 37.5431636,lng: 126.8659771)
    redirect_to show_path(room.id)
  end


  ####################### show (+destroy) ##########################
  def show
    @room = Room.find(params[:id])
    
    # room.places에 current_user있으면 무시, 없으면 추가
    if !@room.places.where(user_id: current_user.id).exists?
      @room.places.create(user_id: current_user.id, lat: 37.5431636,lng: 126.8659771)
    end
    
    if current_user.id == @room.user_id
        @creator = true
    else
        @creator = false
    end
    
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
  
  # 방 강퇴
  def destroy_member
      place = Place.find(params[:id])
      place.destroy
      redirect_to :back
  end
  
  # 방 나가기
  def destroy_self
      place = Place.find(params[:id])
      room = Room.find(place.room_id)
      if room.user_id == current_user.id
          room.destroy
      end
      place.destroy
      redirect_to root_path
  end
  
  #   GPS로 update하기
  def refresh
    @room=Room.find(params[:id])
    place = Place.find_by(room_id: params[:id],user_id: current_user.id)
    
    place.lat = params[:lat]
    place.lng = params[:lon]
   place.save
    
    # count = @room.places.length
    # @sum_lat = 0
    # @sum_lng = 0
    # @room.places.each do |place|
    #   @sum_lat+=place.lat
    #   @sum_lng+=place.lng
    # end
    # @sum_lat/=count
    # @sum_lng/=count
    
    # respond_to do |format|
    #     if place.save
    #       format.js
    #       # format.js 
    #     else
    #     #   format.html { render 'new'} ## Specify the format in which you are rendering "new" page
    #     #   format.json { render json: @reservation.errors } ## You might want to specify a json format as well
    #     end
    # end
  end
  
  ####################### 장소 정하기 (find + save) ##########################
  def find
      @place = Place.find_by(room_id: params[:id], user_id: current_user.id)
  end
  
  def save
      myplace = Place.find_by(room_id: params[:id], user_id: current_user.id)
      myplace.lat = params[:place][:lat]
      myplace.lng = params[:place][:lng]
      myplace.placename= params[:place][:placename]
      myplace.save
      
      redirect_to show_path(params[:id])
  end
  
  ####################### 결과보기 ##########################
  def result
    
    
    @room = Room.find(params[:id])
    mlat = @room.places.map(&:lat).minmax
    mlng = @room.places.map(&:lng).minmax
    count = @room.places.length
   
    loc1 = [mlat[0],mlng[0]]
    loc2 = [mlat[1],mlng[1]]
    @radius = distance(loc1,loc2)/3
    
    @sum_lat = 0
    @sum_lng = 0
    @room.places.each do |place|
        @sum_lat+=place.lat
        @sum_lng+=place.lng
    end
    @sum_lat/=count
    @sum_lng/=count
    
    @likes = @room.likes.where(user_id: current_user.id)
    
    @is_check = true
    @room.places.each do |place|
        if place.check != 1
            @is_check = false
        break
        end
    end
    @like = @room.likes
  end
  
#   장소선택 완료시 check 1
  def like
      room = Room.find(params[:id])
      myplace = room.places.find_by(user_id: current_user.id)
      myplace.check = 1
      myplace.save
      
      redirect_to :back
  end
  def prac
  end
  
   def like_create
        like = Like.find_by(user_id: current_user.id, place: params[:name], room_id: params[:id])
        if like.nil?
            Like.create(user_id: current_user.id, place: params[:name], room_id: params[:id])
            
        else
            like.destroy
            
        end
      respond_to do |format|
        if true
          format.js
          # format.js 
        else
        #   format.html { render 'new'} ## Specify the format in which you are rendering "new" page
        #   format.json { render json: @reservation.errors } ## You might want to specify a json format as well
        end
    end
       
  end

    def like_result
        @likes = Room.find(params[:id]).likes
        
         respond_to do |format|
            if true
              format.js
              # format.js 
            else
            #   format.html { render 'new'} ## Specify the format in which you are rendering "new" page
            #   format.json { render json: @reservation.errors } ## You might want to specify a json format as well
            end
        end
        
    end      
  
  private
      def distance loc1, loc2
        rad_per_deg = Math::PI/180  # PI / 180
        rkm = 6371                  # Earth radius in kilometers
        rm = rkm * 1000             # Radius in meters
      
        dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
        dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg
      
        lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
        lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }
      
        a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      
        rm * c # Delta in meters
      end
end
