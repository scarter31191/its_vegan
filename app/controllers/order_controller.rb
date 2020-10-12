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
    get '/orders/:id' do
        @order = Order.find(params[:id])
        authorized_user
        erb :'/orders/show'
    end

    get '/orders' do
        @orders = current_user.orders
        erb :'/orders/index'
    end
    
        #update
    get '/orders/:id/edit' do
        @order = Order.find(params[:id])
        authorized_user
        erb :'orders/edit'
    end

    patch '/updateorders/:id' do 
        @order = Order.find(params[:id])
        authorized_user
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
        authorized_user
        @order.destroy
        redirect '/orders'
    end


end 