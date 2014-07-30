Rails.application.config.middleware.use OmniAuth::Builder do

#  case Rails.env
#    when "development"
      provider :twitter, 'UnfzxUFtQddLETIpDRwVQ', 'nQPSJT6VamsXV630DjAvL8rVi78Se2YenLKvLeEMg'

      provider :facebook, '381625645257490', 'd6868ead2c4c3c21a6cef5fbe7a5e4e5', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}

      
#    else

#  end
end