class PollsController < ApplicationController
  unloadable

  before_action :find_project,:authorize

  def index
    @polls = VotingPoll.where(:project_id => @project.id)
  end

  def new
    @poll = VotingPoll.new(:project_id => @project.id)
    if request.post? || request.put?
      unlocked_params = ActiveSupport::HashWithIndifferentAccess.new(params.require(:poll).permit(:question, :revote))
      @poll.attributes = unlocked_params
      if @poll.save
        redirect_to :action => 'index', :project_id => @project
      end
    end
  end

  def delete
    VotingPoll.destroy!(params[:id])
    redirect_to :action => 'index', :project_id => @project
  end

  def edit
    @poll = VotingPoll.find(params[:id])
    unlocked_params = ActiveSupport::HashWithIndifferentAccess.new(params.require(:poll).permit(:question, :revote))
    if (request.post?  || request.put?) && @poll.update_attributes(unlocked_params)
      redirect_to :action => 'index', :project_id => @project
    end
  end

  def new_choice
    @poll = VotingPoll.find(params[:poll_id])
    @choice = VotingChoice.new()
    if request.post? || request.put?
      @choice = VotingChoice.new()
      unlocked_params = ActiveSupport::HashWithIndifferentAccess.new(params.require(:choice).permit(:poll_id, :text))
      @choice.attributes = unlocked_params
      if @choice.save
        redirect_to :action => 'index', :project_id => @project
      end
    end
  end

  def remove_choice
    VotingChoice.destroy(params[:id])
    redirect_to :action => 'index', :project_id => @project
  end

  def edit_choice
    @choice = VotingChoice.find(params[:id])
    @poll = VotingPoll.find(params[:poll_id])
    if request.post? || request.put?
      unlocked_params = ActiveSupport::HashWithIndifferentAccess.new(params.require(:choice).permit(:poll_id, :text))
      if @choice.update_attributes(unlocked_params)
        redirect_to :action => 'index', :project_id => @project
      end
    end
  end

  def vote
    choice = VotingChoice.find(params[:choice_id])
    exist_vote = VotingVote.where(:user_id => User.current.id, :poll_id => choice.poll.id)
    if !exist_vote or choice.poll.revote
      exist_vote.destroy_all if exist_vote.count >= 1
      vote = VotingVote.new
      vote.user_id = User.current.id
      vote.poll_id = choice.poll.id;
      vote.choice_id = choice.id;
      vote.save
    end
    back_url = CGI.unescape(params[:back_url].to_s)
    redirect_to back_url
  end

  def reset_vote
    poll = VotingPoll.find(params[:poll_id])
    if poll.revote
       VotingVote.where(:user_id => User.current.id, :poll_id => params[:poll_id].to_i).destroy_all
    end
    back_url = CGI.unescape(params[:back_url].to_s)
    redirect_to back_url
  end


  private
  def find_optional_project
    return true unless params[:project_id]
    @project = Project.find(params[:project_id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

end
