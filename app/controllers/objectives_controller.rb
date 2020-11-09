class ObjectivesController < ApplicationController

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

end

