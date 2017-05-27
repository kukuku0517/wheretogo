class LikesController < ApplicationController
    def create
        like = Like.find_by(user_id: current_user.id, place: params[:name], room_id: params[:id])
        if like.nil?
            Like.create(user_id: current_user.id, place: params[:name], room_id: params[:id])
        else
            like.destroy
        end
        redirect_to :back
    end
end
