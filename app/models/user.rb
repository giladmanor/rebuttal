class User < ActiveRecord::Base
  serialize :social_info, Hash
  
end
