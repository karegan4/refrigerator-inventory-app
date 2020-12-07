class ListItemController < ApplicationController

    #new
    get '/list/new' do
        if logged_in?
            @list_items = current_user.list_items.sort_by {|category_name| category_name.category}
            erb :'list/new'
        else
            redirect to "/"
        end
    end

    #index
    get '/list' do
        if logged_in?
            @list_items = current_user.list_items
            erb :'list/index'
        else
            redirect to "/"
        end
    end

    #show
    get '/list/:id' do
        if logged_in? && current_user.list_items.find_by_id(params[:id])
            @list_item = current_user.list_items.find_by_id(params[:id])
            erb :'list/show'
        else
            erb :"/list/access_denied"
        end
    end

    #edit
    get '/list/:id/edit' do
        @list_item = current_user.list_items.find_by_id(params[:id])
        if logged_in? && @list_item
            erb :'list/edit'
        else
            erb :"/list/access_denied"
        end
    end

    #update
    patch '/list/:id' do
        @list_item = current_user.list_items.find_by_id(params[:id])
        if logged_in? && current_user.list_items.find_by_id(params[:id])
            @list_item.category = params[:category]
            @list_item.name = params[:name]
            @list_item.quantity = params[:quantity]
            @list_item.save
            redirect to "/list/new"
        else
            redirect to "/"
        end
    end

    #create
    post '/list' do
        if logged_in?
            @list_item = current_user.list_items.create(category: params[:category], name: params[:name], quantity: params[:quantity])
            redirect to '/list/new'
        else
            redirect to "/"
        end
    end

    #delete
    delete '/list/:id' do
        @list_item = ListItem.find_by_id(params[:id])
        @list_item.delete
        redirect to '/list/new'
    end
end