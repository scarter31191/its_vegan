class OrderController < ApplicationController

    #create
    get '/orders/new' do
        erb :'/orders/new'
    end

    post '/orders' do
        @order = current_user.orders.create(
            address: params[:address], 
            item: params[:item], 
            item_price: params[:item_price],
            total: params[:total]
            )
        redirect "/orders/#{@order.id}"
    end

    #read

    get '/orders' do
        @orders = current_user.orders
        erb :'/orders/index'
    end

    # get '/orders/all' do
    #     erb :"orders/index"
    #   end

      get '/orders/:id' do
        @order = Order.find(params[:id])
        erb :'/orders/show'
    end
    
        #update
    get '/orders/:id/edit' do
        @order = Order.find(params[:id])
        erb :'orders/edit'
    end

    patch '/updateorders/:id' do
        @order = Order.find(params[:id])
        @order.update(
            address: params[:address], 
            item: params[:item], 
            item_price: params[:item_price],
            total: params[:total]
            )
        redirect "/orders/#{@order.id}"
    end


    #delete
    delete '/orders/:id' do
        @order = Order.find(params[:id])
        @order.destroy
        redirect '/orders'
    end


end