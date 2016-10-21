class UsersController < ApplicationController
	def new

	end

	def edit
		@user = User.where(id: params[:id]).first
		render 'users/edit'
	end

	def update
		@user = User.where(id: params[:id]).first
		if @user.update(fname: params[:fname], lname: params[:lname], email: params[:email], location: params[:location], state: params[:state])
			# flash[:success] = "User info successfully updated!"
			redirect_to "/events"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to "/users/#{@user.id}"
		end
	end
end
