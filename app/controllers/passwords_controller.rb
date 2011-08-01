class PasswordsController < ApplicationController
  # GET /passwords
  # GET /passwords.xml
  def index
    @passwords = Password.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /passwords/1
  # GET /passwords/1.xml
  def show
    @password = Password.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /passwords/new
  # GET /passwords/new.xml
  def new
    @password = Password.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /passwords/verify?user=foo&password=bar
  def verify
    user     = params[:user]
    password = params[:password]

    match = Password.find_all_by_user(user).find do |x|
      x.correct_password? password
    end
    if match
      match.last_used = Time.now
      match.save
      render :text => "SUCCESS\n"
    else
      render :text => "FAILED\n"
    end
  end

  # POST /passwords
  # POST /passwords.xml
  def create
    password = (1..20).map{('a'..'z').to_a[ActiveSupport::SecureRandom.random_number(26)]}.join.gsub(/[^ ]{4}/, '\0 ').strip
    @password = Password.new(
      params[:password].merge(
        :user     => session[:user],
        :password => password
      )
    )

    respond_to do |format|
      if @password.save
        flash[:password] = password
        format.html { redirect_to(@password, :notice => 'Password was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /passwords/1
  # DELETE /passwords/1.xml
  def destroy
    @password = Password.find(params[:id])
    @password.destroy

    respond_to do |format|
      format.html { redirect_to(passwords_url) }
    end
  end
end
