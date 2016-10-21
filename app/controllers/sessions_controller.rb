class SessionsController < ApplicationController
	def new

		render 'sessions/new'
	end

	def login

		user = User.where(email: params[:email]).first
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to '/events'
		else
			flash[:errors] = ["Invalid combination!"]
			redirect_to '/'
		end
	end

	def register
		@user = User.new(fname: params[:fname], lname: params[:lname], email: params[:email], location: params[:location], state: params[:state], password: params[:password], password_confirmation: params[:confirm_pw])
		if @user.save
			session[:user_id] = @user.id
			redirect_to "/events"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to '/'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/'
	end
end
