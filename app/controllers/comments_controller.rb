class CommentsController < ApplicationController

	def create
		@event = Event.where(id: params[:id]).first
	    @comment = Comment.new(content: params[:content], user_id: current_user.id, event_id: @event.id)
	    if @comment.save
	    	redirect_to "/events/#{@event.id}"
	    else
	    	flash[:errors] = @comment.errors.full_messages
	    	redirect_to "/events/#{@event.id}"
	    end
	end
end
