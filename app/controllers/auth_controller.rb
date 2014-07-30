class AuthController < ActionController::Base
  
  
  ##############################################################################
  # OAUTH OAUTH OAUTH OAUTH OAUTH OAUTH OAUTH OAUTH OAUTH OAUTH OAUTH OAUTH OAUTH 
  ##############################################################################
  # -> to configure the location of this callback method go to route.rb and edit the line: "match 'auth/:provider/callback', :to => 'registration#oauth'"
  def oauth
    logger.debug "GETTING OAUTH, session #{session.inspect}"
    logger.debug "OAUTH PARAMS: #{params.inspect}"

    if social_connect
      redirect_to "/"
      #render :json=>{:error=>"ok"}
    else
      render :json=>{:error=>"not quite"}
    end
  end


  ##############################################################################
  # PROPER LOGIN  PROPER LOGIN  PROPER LOGIN  PROPER LOGIN  PROPER LOGIN  PROPER LOGIN  
  ##############################################################################

  def login
    email = params[:email].downcase
    pwd = params[:password]
    
    @user = User.find_by_email_and_password(email, pwd)
    if @user
      session[:user_id] =  @user.neo_id
      render :json=>{:login=>"ok"}
    else
      render :json=>{:login=>"Bad Attempt"}
    end
  end
  
  
  ##############################################################################
  # STUPID ASS FORGOT PASSWORD STUPID ASS FORGOT PASSWORD STUPID ASS FORGOT PASSWORD 
  ##############################################################################

  def forgot
    email = params[:email].downcase
    
    @user = User.find_by_email_address(email)
    if @user
      #send the stupid fuck an email
      UserMailer.forgot_password(@user).deliver if @user.facebook_id.nil?
      render :json=>{:login=>"ok"}
    else
      render :json=>{:login=>"Bad Attempt"}
    end
  end

  ##############################################################################
  # PROPER REGISTER  PROPER REGISTER  PROPER REGISTER  PROPER REGISTER  PROPER REGISTER    
  ##############################################################################

  def register
    #Register
    @error=[]
    
    r = /\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/
    if params[:email_address].nil? || params[:email_address].length==0 || !params[:email_address].match(r)
      @error<<"Please enter a valid email"
    else
      @error<<"Email is already in use" unless User.find_by_email_address(params[:email_address].downcase).nil?
    end
    
    @error<<"You need to agree to the terms of service" unless params[:agree]
    @error<<"Please set a password" if params[:password].nil? || params[:password].length==0  
    @error<<"Please make sure password matches confirm" unless params[:password]==params[:re_password] 
    if @error.empty?
      p = params
      p[:email_address] =p[:email_address].downcase 
      
      user = User.new()
      attr = p.delete_if{|k,v| !user.respond_to?(k.to_sym)}
      user.update_attributes(attr)
      
      if user.save
        session[:user_id] =  user.neo_id
        render :json=>{:login=>"ok"}
        return
      else
        logger.debug user.errors.inspect unless user.nil?
        @error += user.errors.messages.map{|k,v| "#{k} #{v}"}.join(', ')
      end  
    end
    render :json =>{:error=>@error}
    
  end



  ##############################################################################
  # UNREGISTER UNREGISTER UNREGISTER UNREGISTER UNREGISTER UNREGISTER UNREGISTER   
  ##############################################################################
  
  def unregister
    session[:user_id] = nil
    render :json=> "ok"
  end



  ##############################################################################
  # LOGOUT LOGOUT LOGOUT LOGOUT LOGOUT LOGOUT LOGOUT LOGOUT LOGOUT LOGOUT LOGOUT  
  ##############################################################################
  
  def logout
    session[:user_id] = nil
    render :json=> "ok"
  end
  
  ##############################################################################
  # PRIVATE PRIVATE PRIVATE PRIVATE PRIVATE PRIVATE PRIVATE PRIVATE PRIVATE PRIVATE  
  ##############################################################################
  private
  

  def social_connect
    logger.debug "SOCIAL CONNECT"
    
    o = request.env["omniauth.auth"]
    logger.debug("OAUTH O-INFO for #{params["provider"]}: #{o["info"].inspect}") if o["info"].present?
    logger.debug("OAUTH session: #{session.inspect}")

    uid = o[:uid]
    provider = params["provider"]
    
    user = create_or_update_user(uid,o["info"], o["extra"]["raw_info"], provider)
    logger.debug user.inspect
    session[:user_id] =  user.neo_id
    user
  end

  def create_or_update_user(uid,info,raw_info,provider)
    key_sym = "#{provider}_id".to_sym
    user = User.first(key_sym=>uid) || User.new({key_sym=>uid, :password=>uid.hash})
    
    provider = "Tweetcon" if provider.downcase == "twitter" # probably conjunctions with Twitter gem
    h = provider.singularize.camelize.constantize.convert(info, raw_info)
    h.each{|k,v| user[k]=v if user[k].nil?}
    user.save
    user
  end
  

  
end
