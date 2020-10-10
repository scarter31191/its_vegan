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
                redirect "/users/#{@user.id}"
            end
    end

    get '/users/login' do
        if logged_in?
            @user = User.find(session[:user_id])
            redirect "/users/#{@user.id}"
        else
            erb :'users/login'
        end
    end

    post '/users/login' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
           session[:user_id] = @user.id
           redirect "/users/#{@user.id}"
        else
            redirect "/users/login"
        end
    end

    get '/users/:id' do
        @user = User.find(params[:id])
        erb :'/users/show'
    end

    get '/users/:id/logout' do
        session.clear
        redirect '/'
    end

end