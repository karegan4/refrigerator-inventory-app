require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :welcome
  end

  get "/signup" do
    erb :'/registrations/signup'
  end

  post "/signup" do
    erb :'/registrations/signup'
  end

  get '/registrations' do
    erb :'/registrations/signup'
  end

  post "/registrations" do
    puts params
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
    redirect to "/registrations/thankyou"
  end

  get '/registrations/thankyou' do
    erb :'/registrations/thankyou'
  end



  get "/sessions/login" do
    erb :'sessions/login'
  end

  post "/sessions/login" do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/foods/new'
    end
    redirect '/signinerror'
  end

  get '/signinerror' do
    erb :'sessions/signinerror'
  end

  #new
  get "/foods/new" do
    @foods = Food.all
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
    redirect to "/foods/#{@food.id}"
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
