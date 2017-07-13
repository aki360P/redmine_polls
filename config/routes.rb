if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    get 'projects/:project_id/polls' => 'polls#index'
    get 'projects/:project_id/polls/new' => 'polls#new'
    post 'projects/:project_id/polls/new' => 'polls#new'
    get 'projects/:project_id/polls/:id/edit' => 'polls#edit'
    post 'projects/:project_id/polls/:id/edit' => 'polls#edit'
    get 'projects/:project_id/polls/:id/delete' => 'polls#delete'
    post 'projects/:project_id/polls/:id/delete' => 'polls#delete'
    get 'projects/:project_id/polls/vote' => 'polls#vote'
    post 'projects/:project_id/polls/vote' => 'polls#vote'
    get 'projects/:project_id/polls/new_choice' => 'polls#new_choice'
    post 'projects/:project_id/polls/new_choice' => 'polls#new_choice'
    get 'projects/:project_id/polls/:poll_id/edit_choice/:id' => 'polls#edit_choice'
    post 'projects/:project_id/polls/:poll_id/edit_choice/:id' => 'polls#edit_choice'
    get 'projects/:project_id/polls/remove_choice/:id' => 'polls#remove_choice'
    post 'projects/:project_id/polls/remove_choice/:id' => 'polls#remove_choice'
    get 'projects/:project_id/polls/:poll_id/reset_vote' => 'polls#reset_vote'
    post 'projects/:project_id/polls/:poll_id/reset_vote' => 'polls#reset_vote'
  end
end
