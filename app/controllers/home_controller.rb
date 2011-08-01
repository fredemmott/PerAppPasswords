class HomeController < ApplicationController
  def index
      user = 'fred'
#    authenticate_with_http_basic do |user,password|
      # TODO: GOOGLE AUTH
      session[:user] = user
      redirect_to :controller => :passwords, :method => :index
#    end
  end
end
