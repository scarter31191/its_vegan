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

  get "/error" do
    erb :error
  end

  helpers do

    def current_user
      User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def authorized_user
      @creator_of_order = Order.find(params[:id]).user_id
        if current_user.id != @creator_of_order
          redirect "/error"
        end
    end

  end

end
