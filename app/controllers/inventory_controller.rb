require './config/environment'

class InventoryController < ApplicationController
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end

  #new
  get "/foods/new" do
    @foods = Food.all
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