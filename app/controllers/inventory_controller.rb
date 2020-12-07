class InventoryController < ApplicationController

  get '/foods/all' do
    @foods = Food.all
    erb :"/inventory/all"
  end

  #new
  get "/foods/new" do
    if logged_in?
      @foods = current_user.foods.sort_by {|category_name| category_name.category}
      erb :'inventory/new'
    else
      redirect to "/"
    end
  end
 

  #index
  get '/foods' do
    if logged_in? && current_user.foods
      @foods = current_user.foods
      erb :'inventory/index'
    else
      redirect to "/"
    end
  end

  #show
  get "/foods/:id" do 
    if logged_in? && current_user.foods.find_by_id(params[:id])
      @food = current_user.foods.find_by_id(params[:id])
      erb :'inventory/show'
    else
      erb :"/inventory/access_denied"
    end
  end

  #edit
  get '/foods/:id/edit' do
      @food = current_user.foods.find_by_id(params[:id])
    if logged_in? && @food
      erb :'inventory/edit'
    else
      erb :"/inventory/access_denied"
    end
  end

  #update
  patch '/foods/:id' do
      @food = current_user.foods.find_by_id(params[:id])
    if logged_in? && @food
      @food.category = params[:category]
      @food.name = params[:name]
      @food.quantity = params[:quantity]
      @food.save
      redirect to "/foods/new"
    else
      redirect to "/"
    end
  end

  #create
  post '/foods' do
    if logged_in? 
      @food = current_user.foods.create(category: params[:category], name: params[:name], quantity: params[:quantity])
      redirect "/foods/new"
    else
      redirect to "/"
    end
    
  end

  #delete
  delete '/foods/:id' do
    if !logged_in? 
      redirect to "/"
    end
    @food = current_user.foods.find_by_id(params[:id])
    if @food
      @food.delete
      redirect to '/foods/new'
    else
      redirect to "/"
    end
  end



end