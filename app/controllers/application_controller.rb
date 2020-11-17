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
      redirect '/inventory'
    end
    redirect '/signinerror'
  end

  get '/signinerror' do
    erb :'sessions/signinerror'
  end

  post '/inventory' do
    @produceitem = params[:produceitem]
    @producenumber = params[:producenumber]
    @meatitem = params[:meatitem]
    @meatnumber = params[:meatnumber]
    @dairyitem = params[:dairyitem]
    @dairynumber = params[:dairynumber]
    erb :'inventory/new'
  end

  #new
  get "/inventory" do
    @produceitem = FridgeFoods.new
    @producenumber = FridgeFoods.new
    @meatitem = FridgeFoods.new
    @meatnumber = FridgeFoods.new
    @dairyitem = FridgeFoods.new
    @dairynumber = FridgeFoods.new
    erb :'inventory/new'
  end

  #index
  get '/inventory/index' do
    @foods = FridgeFoods.all 
    erb :'inventory/index'
  end

  #show
  get '/inventory/:id' do 
    @food = FridgeFoods.find_by_id(params[:id])
    erb :show
  end

  #edit
  get '/inventory/:id/edit' do
    @foods = FridgeFoods.find_by_id(params[:id])
    erb :edit
  end
  
  #create

  #delete
  delete '/inventory/:id' do
    @food = FridgeFoods.find_by_id(params[:id])
    @food.delete
    redirect to '/inventory'
  end

end
