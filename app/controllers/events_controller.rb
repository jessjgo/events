class EventsController < ApplicationController
  def index
    @user = User.where(id: session[:user_id]).first
    user_state = User.where(id: session[:user_id]).first.state
    @my_events = Event.where(state: user_state)
    @other_events = Event.where.not(state: user_state)
    render 'events/index'
  end

  def create
    @event = Event.new(name: params[:name], event_date: params[:event_date], location: params[:location], state: params[:state], user_id: session[:user_id])
    if @event.save
      redirect_to '/events'
    else
      flash[:errors] = @event.errors.full_messages
      redirect_to '/events'
    end
  end

  def create_join
    event = Event.where(id: params[:event_id]).first
    join = Attendee.create(user_id: current_user.id, event_id: params[:event_id])
    redirect_to '/events'
  end

  def destroy_join
    join = Attendee.where(user_id: current_user.id, event_id: params[:event_id]).first.destroy
    redirect_to '/events'
  end

  def show
    @event = Event.where(id: params[:id]).first
    @event_user = User.where(id: @event)
    @event_count = @event.attendees.count
    @event_users_list = Event.where(id: @event.id).first.users_attending_it

    # @comment = Comment.where(event_id: @event.id)
    # @user = User.where(id: @comment.user_id)
    # @event_comments = 
    @user_comment = Event.where(id: @event).first.users_commented_on_it
    @event_comment_list = Comment.where(event_id: @event.id)

    render 'events/show'
  end

  def edit
  end

  def update

  end

  def destroy
    event = Event.where(id: params[:id]).first
    event.destroy if event.user == current_user
    redirect_to '/events'
  end
end

# Event.where(id:1).first.users_commented_on_it
# finds all users that have commented on event 1

# Event.where(id:1)first.users_attending_it
# finds all users that are attending event 1

# User.where(id:1).first.events_they_have_commented_on
# finds all events user 1 has commented on

# User.where(id:1)first.events_they_are_attending
# finds all events user 1 is attending