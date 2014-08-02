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
    session[:user_id] =  user.id
    user
  end

  def create_or_update_user(uid,info,raw_info,provider)
    User.where(:ooth_id=>uid).first || User.create(:ooth_id=>uid, :ooth_source=>provider)
  end
  

  
end
