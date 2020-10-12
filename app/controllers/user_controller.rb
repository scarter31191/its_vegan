class UserController < ApplicationController

    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do
        @user = User.new(
        username: params[:username],
        password: params[:password]
        ) 
        @user.save
        session[:user_id] = @user.id
            if @user.id == nil
                erb :'error'
            else
                redirect "/home"
            end
    end

    get '/users/login' do
        if logged_in?
            @user = User.find(session[:user_id])
            redirect "/home"
        else
            erb :'users/login'
        end
    end

    post '/users/login' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
           session[:user_id] = @user.id
           redirect "/home"
        else
            redirect "/users/login"
        end
    end

    get '/home' do
        @user = current_user
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end