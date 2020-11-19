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


end
