require 'rack-flash'
class ObjectivesController < ApplicationController
enable :sessions
use Rack::Flash
  
get '/objectives' do
    if logged_in?
      @objectives = Objective.all
      erb :'objectives/objectives'
    else
      redirect to '/login'
    end
  end

  get '/objectives/new' do
    if logged_in?
      erb :'objectives/create_objective'
    else
      redirect to '/login'
    end
  end

  post '/objectives' do
    if logged_in?
      if params[:content] == ""
        redirect to "/objectives/new"
      else
        @objective = current_user.objectives.build(name: params[:name], idea: params[:idea], content: params[:content])
        if @objective.save
          redirect to "/objectives/#{@objective.id}"
        else
          redirect to "/objectives/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/objectives/:id' do
    if logged_in?
      @objective = Objective.find_by(id: params[:id])
      erb :'objectives/show_objective'
    else
      redirect to '/login'
    end
  end

  get '/objectives/:id/edit' do
    if logged_in?
      @objective = Objective.find_by_id(params[:id])
      if @objective && @objective.user == current_user
        erb :'objectives/edit_objective'
      else
        redirect to '/objectives', flash[:alert] = "You are not authorized to make changes."
      end
    else
      redirect to '/login'
    end
  end

  patch '/objectives/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/objectives/#{params[:id]}/edit"
      else
        @objective = Objective.find_by_id(params[:id])
        if @objective && @objective.user == current_user
          if @objective.update(name: params[:name], idea: params[:idea], content: params[:content])
            redirect to "/objectives/#{@objective.id}"
          else
            redirect to "/objectives/#{@objective.id}/edit"
          end
        else
          redirect to '/objectives'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/objectives/:id/delete' do
    if logged_in?
      @objective = Objective.find_by_id(params[:id])
      if @objective && @objective.user == current_user
        @objective.delete
      end
      redirect to '/objectives'
    else
      redirect to '/login'
    end
  end
    

end

