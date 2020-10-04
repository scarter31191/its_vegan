require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret,  'secret'
  end

  get "/" do
    erb :welcome
  end

  get "/goodbye" do
    erb :goodbye
  end

  helpers do

    def current_user
      User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def authorized_user?(order)
      order.user == current_user
    end

  end

end