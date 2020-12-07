require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do
    #returns true if there is a user_id in the session hash, indicating a user is signed in
    def logged_in?
      !!session[:user_id]
    end
    #returns the instance of a user that is signed in, assigns them to @current_user
    def current_user
      @current_user ||=User.find_by(id: session[:user_id])
    end
  end

  get "/" do
    @message = session[:message]
    session[:message] = nil
    erb :welcome
  end

  get "/signup" do
    erb :'/registrations/signup'
  end

  post "/registrations" do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect to "/foods/new"
    else
      redirect to "/signup"
    end
  end


  get '/registrations/thankyou' do
    erb :'/registrations/thankyou'
  end

  get "/sessions/login" do
    erb :'sessions/login'
  end

   post '/sessions' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/foods/new'
    end
    redirect '/signinerror'
  end

  get '/signinerror' do
    erb :'sessions/signinerror'
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

end
