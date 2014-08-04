class Statement < ActiveRecord::Base
  acts_as_tree
  belongs_to :user
  before_save :calculate_rank
  
  
  
  def conversation_size
    return self.children.size if parent.nil?
    parent.children.size
  end
  
  private
  
  def calculate_rank
    post_time = self.created_at.nil? ? Time.now.to_i : self.created_at.to_i
    votes = (self.upvotes || 0) - (self.downvotes || 0) + 0.0001
    self.rank = 45000 * Math.log10(votes) + post_time - 1128211200
  end
  
  
  
end
