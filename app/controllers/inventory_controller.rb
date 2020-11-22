require './config/environment'

class InventoryController < ApplicationController
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end

  #new
  get "/foods/new" do
    @foods = Food.all.sort_by {|category_name| category_name.category}
    @inv_foods = {} 
    Food.all.each do |food|
      cat = food.category 
      if @inv_foods[cat] 
        @inv_foods[cat] << food 
      else 
        @inv_foods[cat] = [food]
      end
    end

    @cats = @inv_foods.keys

    @values = @inv_foods.values



    @food = Food.find_by_id(params[:id])
    erb :'inventory/new'
  end
 

  #index
  get '/foods' do
    @foods = Food.all 
    erb :'inventory/index'
  end

  #show
  get "/foods/:id" do 
    @food = Food.find_by_id(params[:id])
    erb :'inventory/show'
  end

  #edit
  get '/foods/:id/edit' do
    @food = Food.find_by_id(params[:id])
    erb :'inventory/edit'
  end

  #update
  patch '/foods/:id' do
    @food = Food.find_by_id(params[:id])
    @food.category = params[:category]
    @food.name = params[:name]
    @food.quantity = params[:quantity]
    @food.save
    redirect to "/foods/new"
  end

  #create
  post '/foods' do
    @food = Food.create(params)
    redirect "/foods/new"
    
  end

  #delete
  delete '/foods/:id' do
    @food = Food.find_by_id(params[:id])
    @food.delete
    redirect to '/foods/new'
  end

end