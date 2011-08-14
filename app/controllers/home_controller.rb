require 'ga_verify/client'
class HomeController < ApplicationController
  def index
    authenticate_with_http_basic do |user,password|
      @code = params[:otpcode].to_i || nil

      begin
        @result = GAVerify::Client.new.check_user(user, @code)
      rescue Thrift::TransportException
        # No server, or server is down
        @result = GAVerify::Result::NO_GOOGLE_AUTH
      end

      passable = [
        GAVerify::Result::SUCCESS,
        GAVerify::Result::NO_GOOGLE_AUTH
      ]
      if passable.include? @result
        session[:user] = user
        redirect_to :controller => :passwords, :method => :index
      else
        render
      end
    end
  end
end
