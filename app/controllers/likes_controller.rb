class LikesController < ApplicationController
    # 장소 name을 리스트에 등록
    def create
        like = Like.find_by(user_id: current_user.id, place: params[:name], room_id: params[:id])
        if like.nil?
            Like.create(user_id: current_user.id, place: params[:name], room_id: params[:id])
            return 1
        else
            like.destroy
            return 0
        end
       respond_to do |format| 
        if true 
            
            format.html { render :nothing => true, :notice => 'Update SUCCESSFUL!' } 
        else 
           
        end 
    end  
    end
end
