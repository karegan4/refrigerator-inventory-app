require './config/environment'

class ListItemController < ApplicationController
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    #new
    get '/list/new' do
        @list_items = ListItem.all
        @list_item = ListItem.find_by_id(params[:id])
        erb :'list/new'
    end

    #index
    get '/list' do
        @list_items = ListItem.all
        erb :'list/index'
    end

    #show
    get '/list/:id' do
        @list_item = ListItem.find_by_id(params[:id])
        erb :'list/show'
    end

    #edit
    get '/list/:id/edit' do
        @list_item = ListItem.find_by_id(params[:id])
        erb :'list/edit'
    end

    #update
    patch '/list/:id' do
        @list_item = ListItem.find_by_id(params[:id])
        @list_item.category = params[:category]
        @list_item.name = params[:name]
        @list_item.quantity = params[:quantity]
        @list_item.save
        redirect to "/list/new"
    end

    #create
    post '/list' do
        @list_item = ListItem.create(params)
        redirect to '/list/new'
    end

    #delete
    delete '/list/:id' do
        @list_item = ListItem.find_by_id(params[:id])
        @list_item.delete
        redirect to '/list/new'
    end
end