require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    if !Helpers.current_user(session)
      @user = User.find_by(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/account'
    else
      if !Helpers.is_logged_in?
        erb :error
      else
        erb :account
      end
    end

  end

  get '/account' do
    erb :account
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
